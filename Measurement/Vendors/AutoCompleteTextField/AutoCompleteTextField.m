//
//  AutoCompleteTextField.m
//  uitextFieldTabV
//
//  Created by DTSoft on 15/1/5.
//  Copyright (c) 2015年 山西金仕达软件有限公司. All rights reserved.
//

#import "AutoCompleteTextField.h"

static NSString *kKeyboardAccessoryInputKeyPath = @"autoCompleteTableAppearsAsKeyboardAccessory";
static NSString *kBorderStyleKeyPath = @"borderStyle";
static NSString *kAutoCompleteTableViewHiddenKeyPath = @"autoCompleteTableView.hidden";
static NSString *kBackgroundColorKeyPath = @"backgroundColor";
static NSString *kDefaultAutoCompleteCellIdentifier = @"_DefaultAutoCompleteCellIdentifier";
@interface AutoCompleteTextField ()
@property (strong, readwrite) UITableView *autoCompleteTableView;
@property (strong) NSArray *autoCompleteSuggestions;
@property (strong) NSOperationQueue *autoCompleteSortQueue;
@property (strong) NSOperationQueue *autoCompleteFetchQueue;
@property (strong) NSString *reuseIdentifier;
@property (assign) CGColorRef originalShadowColor;
@property (assign) CGSize originalShadowOffset;
@property (assign) CGFloat originalShadowOpacity;
@end

@implementation AutoCompleteTextField


#pragma mark - Init

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

//- (void)dealloc
//{
//    [self closeAutoCompleteTableView];
//    [self stopObservingKeyPathsAndNotifications];
//}

- (void)initialize
{
    [self beginObservingKeyPathsAndNotifications];
    
    [self setDefaultValuesForVariables];
    
    UITableView *newTableView = [self newAutoCompleteTableViewForTextField:self];
    [self setAutoCompleteTableView:newTableView];
    
    [self styleAutoCompleteTableForBorderStyle:self.borderStyle];
}


#pragma mark - Notifications and KVO

- (void)beginObservingKeyPathsAndNotifications
{
    [self addObserver:self
           forKeyPath:kBorderStyleKeyPath
              options:NSKeyValueObservingOptionNew context:nil];
    
    
    [self addObserver:self
           forKeyPath:kAutoCompleteTableViewHiddenKeyPath
              options:NSKeyValueObservingOptionNew context:nil];
    
    
    [self addObserver:self
           forKeyPath:kBackgroundColorKeyPath
              options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self
           forKeyPath:kKeyboardAccessoryInputKeyPath
              options:NSKeyValueObservingOptionNew context:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChangeWithNotification:)
                                                 name:UITextFieldTextDidChangeNotification object:self];
}

- (void)stopObservingKeyPathsAndNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self removeObserver:self forKeyPath:kBorderStyleKeyPath];
    [self removeObserver:self forKeyPath:kAutoCompleteTableViewHiddenKeyPath];
    [self removeObserver:self forKeyPath:kBackgroundColorKeyPath];
    [self removeObserver:self forKeyPath:kKeyboardAccessoryInputKeyPath];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:kBorderStyleKeyPath])
    {
        [self styleAutoCompleteTableForBorderStyle:self.borderStyle];
        
    } else if ([keyPath isEqualToString:kAutoCompleteTableViewHiddenKeyPath])
    {
        if(self.autoCompleteTableView.hidden){
            [self closeAutoCompleteTableView];
        } else {
            [self.autoCompleteTableView reloadData];
        }
    } else if ([keyPath isEqualToString:kBackgroundColorKeyPath]){
        [self styleAutoCompleteTableForBorderStyle:self.borderStyle];
    } else if ([keyPath isEqualToString:kKeyboardAccessoryInputKeyPath]){
        if(self.autoCompleteTableAppearsAsKeyboardAccessory){
            [self setAutoCompleteTableForKeyboardAppearance];
        } else {
            [self setAutoCompleteTableForDropDownAppearance];
        }
    }
}

#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = [self.autoCompleteSuggestions count];
    [self expandAutoCompleteTableViewForNumberOfRows:numberOfRows];
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *cellIdentifier = kDefaultAutoCompleteCellIdentifier;
    
    if(!self.reuseIdentifier){
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [self autoCompleteTableViewCellWithReuseIdentifier:cellIdentifier];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier];
    }
    NSAssert(cell, @"Unable to create cell for autocomplete table");
    
    
    id autoCompleteObject = self.autoCompleteSuggestions[indexPath.row];
    NSString *suggestedString;
    if([autoCompleteObject isKindOfClass:[NSString class]]){
        suggestedString = (NSString *)autoCompleteObject;
    } else if ([autoCompleteObject conformsToProtocol:@protocol(AutoCompletionObject)]){
        suggestedString = [(id <AutoCompletionObject>)autoCompleteObject autocompleteString];
    } else {
        NSAssert(0, @"Autocomplete suggestions must either be NSString or objects conforming to the MLPAutoCompletionObject protocol.");
    }
    
    
    [self configureCell:cell atIndexPath:indexPath withAutoCompleteString:suggestedString];
    
    
    return cell;
}

- (UITableViewCell *)autoCompleteTableViewCellWithReuseIdentifier:(NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:identifier];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:self.textColor];
    [cell.textLabel setFont:self.font];
    return cell;
}

+ (NSString *) accessibilityLabelForIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];
}

- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
withAutoCompleteString:(NSString *)string
{
    
    NSAttributedString *boldedString = nil;
    BOOL attributedTextSupport = [cell.textLabel respondsToSelector:@selector(setAttributedText:)];
    if(attributedTextSupport && self.applyBoldEffectToAutoCompleteSuggestions){
        NSRange boldedRange = [string rangeOfString:self.text options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch];
        boldedString = [self boldedString:string withRange:boldedRange];
    }
    
    id autoCompleteObject = self.autoCompleteSuggestions[indexPath.row];
    if(![autoCompleteObject conformsToProtocol:@protocol(AutoCompletionObject)]){
        autoCompleteObject = nil;
    }
    
    if([self.autoCompleteDelegate respondsToSelector:@selector(autoCompleteTextField:shouldConfigureCell:withAutoCompleteString:withAttributedString:forAutoCompleteObject:forRowAtIndexPath:)])
    {
        if(![self.autoCompleteDelegate autoCompleteTextField:self shouldConfigureCell:cell withAutoCompleteString:string withAttributedString:boldedString forAutoCompleteObject:autoCompleteObject forRowAtIndexPath:indexPath])
        {
            return;
        }
    }
    
    [cell.textLabel setTextColor:self.textColor];
    
    if(boldedString){
        if ([cell.textLabel respondsToSelector:@selector(setAttributedText:)]) {
            [cell.textLabel setAttributedText:boldedString];
        } else{
            [cell.textLabel setText:string];
            [cell.textLabel setFont:[UIFont fontWithName:self.font.fontName size:self.autoCompleteFontSize]];
        }
        
    } else {
        [cell.textLabel setText:string];
        [cell.textLabel setFont:[UIFont fontWithName:self.font.fontName size:self.autoCompleteFontSize]];
    }
    
    cell.accessibilityLabel = [[self class] accessibilityLabelForIndexPath:indexPath];
    
    if(self.autoCompleteTableCellTextColor){
        [cell.textLabel setTextColor:self.autoCompleteTableCellTextColor];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:self.autoCompleteTableCellBackgroundColor];
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.autoCompleteRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.autoCompleteTableAppearsAsKeyboardAccessory){
        [self closeAutoCompleteTableView];
    }
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *autoCompleteString = selectedCell.textLabel.text;
    self.text = autoCompleteString;
    
    id<AutoCompletionObject> autoCompleteObject = self.autoCompleteSuggestions[indexPath.row];
    if(![autoCompleteObject conformsToProtocol:@protocol(AutoCompletionObject)]){
        autoCompleteObject = nil;
    }
    
    if([self.autoCompleteDelegate respondsToSelector:
        @selector(autoCompleteTextField:didSelectAutoCompleteString:withAutoCompleteObject:forRowAtIndexPath:)]){
        
        [self.autoCompleteDelegate autoCompleteTextField:self
                             didSelectAutoCompleteString:autoCompleteString
                                  withAutoCompleteObject:autoCompleteObject
                                       forRowAtIndexPath:indexPath];
    }
    
    [self finishedSearching];
}

#pragma mark - AutoComplete Sort Operation Delegate


- (void)autoCompleteTermsDidSort:(NSArray *)completions
{
    [self setAutoCompleteSuggestions:completions];
    [self.autoCompleteTableView reloadData];
    
    self.autoCompleteTableView.backgroundColor = [UIColor whiteColor];
    
//    if ([self.autoCompleteDelegate
//         respondsToSelector:@selector(autoCompleteTextField:didChangeNumberOfSuggestions:)]) {
//        [self.autoCompleteDelegate autoCompleteTextField:self
//                            didChangeNumberOfSuggestions:self.autoCompleteSuggestions.count];
//    }

}


#pragma mark - Events

- (void)textFieldDidChangeWithNotification:(NSNotification *)aNotification
{
//    if(aNotification.object == self){
//        [self reloadData];
//    }
}

- (BOOL)becomeFirstResponder
{
    [self saveCurrentShadowProperties];
    
    if(self.showAutoCompleteTableWhenEditingBegins ||
       self.autoCompleteTableAppearsAsKeyboardAccessory){
        [self fetchAutoCompleteSuggestions];
    }
    
    return [super becomeFirstResponder];
}

- (void) finishedSearching
{
    if (self.shouldResignFirstResponderFromKeyboardAfterSelectionOfAutoCompleteRows) {
        [self resignFirstResponder];
    }
}

- (BOOL)resignFirstResponder
{
    [self restoreOriginalShadowProperties];
    if(!self.autoCompleteTableAppearsAsKeyboardAccessory){
        [self closeAutoCompleteTableView];
    }
    return [super resignFirstResponder];
}



#pragma mark - Open/Close Actions

- (void)expandAutoCompleteTableViewForNumberOfRows:(NSInteger)numberOfRows
{
    NSAssert(numberOfRows >= 0,
             @"Number of rows given for auto complete table was negative, this is impossible.");
    
    if(!self.isFirstResponder){
        return;
    }
    
    if(self.autoCompleteTableAppearsAsKeyboardAccessory){
        [self expandKeyboardAutoCompleteTableForNumberOfRows:numberOfRows];
    } else {
        [self expandDropDownAutoCompleteTableForNumberOfRows:numberOfRows];
    }
    
}

- (void)expandKeyboardAutoCompleteTableForNumberOfRows:(NSInteger)numberOfRows
{
    if(numberOfRows && (self.autoCompleteTableViewHidden == NO)){
        [self.autoCompleteTableView setAlpha:1];
    } else {
        [self.autoCompleteTableView setAlpha:0];
    }
}

- (void)expandDropDownAutoCompleteTableForNumberOfRows:(NSInteger)numberOfRows
{
    [self resetDropDownAutoCompleteTableFrameForNumberOfRows:numberOfRows];
    
    
    if(numberOfRows && (self.autoCompleteTableViewHidden == NO)){
        [self.autoCompleteTableView setAlpha:1];
        
        if(!self.autoCompleteTableView.superview){
            if([self.autoCompleteDelegate
                respondsToSelector:@selector(autoCompleteTextField:willShowAutoCompleteTableView:)]){
                [self.autoCompleteDelegate autoCompleteTextField:self
                                   willShowAutoCompleteTableView:self.autoCompleteTableView];
            }
        }
        
        [self.superview bringSubviewToFront:self];
#if BROKEN
        UIView *rootView = [self.window.subviews objectAtIndex:0];
        [rootView insertSubview:self.autoCompleteTableView
                   belowSubview:self];
#else
        [self.superview insertSubview:self.autoCompleteTableView
                         belowSubview:self];
#endif
        [self.autoCompleteTableView setUserInteractionEnabled:YES];
        if(self.showTextFieldDropShadowWhenAutoCompleteTableIsOpen){
            [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
            [self.layer setShadowOffset:CGSizeMake(0, 1)];
            [self.layer setShadowOpacity:0.35];
        }
    } else {
        [self closeAutoCompleteTableView];
        [self restoreOriginalShadowProperties];
        [self.autoCompleteTableView.layer setShadowOpacity:0.0];
    }
}


- (void)closeAutoCompleteTableView
{
    [self.autoCompleteTableView removeFromSuperview];
    [self restoreOriginalShadowProperties];
}


#pragma mark - Setters



- (void)setDefaultValuesForVariables
{
    [self setClipsToBounds:NO];

    [self setApplyBoldEffectToAutoCompleteSuggestions:YES];
    [self setShowTextFieldDropShadowWhenAutoCompleteTableIsOpen:YES];
    [self setShouldResignFirstResponderFromKeyboardAfterSelectionOfAutoCompleteRows:YES];
    [self setAutoCompleteRowHeight:40];
    [self setAutoCompleteFontSize:13];
    [self setMaximumNumberOfAutoCompleteRows:3];
    [self setPartOfAutoCompleteRowHeightToCut:0.5f];
    
    [self setAutoCompleteTableCellBackgroundColor:[UIColor clearColor]];
    
    UIFont *regularFont = [UIFont systemFontOfSize:13];
    [self setAutoCompleteRegularFontName:regularFont.fontName];
    
    UIFont *boldFont = [UIFont boldSystemFontOfSize:13];
    [self setAutoCompleteBoldFontName:boldFont.fontName];
    
    [self setAutoCompleteSuggestions:[NSMutableArray array]];
    
//    [self setAutoCompleteSortQueue:[NSOperationQueue new]];
//    self.autoCompleteSortQueue.name = [NSString stringWithFormat:@"Autocomplete Queue %i", arc4random()];
    
//    [self setAutoCompleteFetchQueue:[NSOperationQueue new]];
//    self.autoCompleteFetchQueue.name = [NSString stringWithFormat:@"Fetch Queue %i", arc4random()];
}


- (void)setAutoCompleteTableForKeyboardAppearance
{
    [self resetKeyboardAutoCompleteTableFrameForNumberOfRows:self.maximumNumberOfAutoCompleteRows];
    [self.autoCompleteTableView setContentInset:UIEdgeInsetsZero];
    [self.autoCompleteTableView setScrollIndicatorInsets:UIEdgeInsetsZero];
    [self setInputAccessoryView:self.autoCompleteTableView];
}

- (void)setAutoCompleteTableForDropDownAppearance
{
    [self resetDropDownAutoCompleteTableFrameForNumberOfRows:self.maximumNumberOfAutoCompleteRows];
    [self.autoCompleteTableView setContentInset:self.autoCompleteContentInsets];
    [self.autoCompleteTableView setScrollIndicatorInsets:self.autoCompleteScrollIndicatorInsets];
    [self setInputAccessoryView:nil];
}



- (void)setAutoCompleteTableViewHidden:(BOOL)autoCompleteTableViewHidden
{
    [self.autoCompleteTableView setHidden:autoCompleteTableViewHidden];
}

- (void)setAutoCompleteTableBackgroundColor:(UIColor *)autoCompleteTableBackgroundColor
{
    [self.autoCompleteTableView setBackgroundColor:autoCompleteTableBackgroundColor];
    _autoCompleteTableBackgroundColor = autoCompleteTableBackgroundColor;
}

- (void)setAutoCompleteTableBorderWidth:(CGFloat)autoCompleteTableBorderWidth
{
    [self.autoCompleteTableView.layer setBorderWidth:autoCompleteTableBorderWidth];
    _autoCompleteTableBorderWidth = autoCompleteTableBorderWidth;
}

- (void)setAutoCompleteTableBorderColor:(UIColor *)autoCompleteTableBorderColor
{
    [self.autoCompleteTableView.layer setBorderColor:[autoCompleteTableBorderColor CGColor]];
    _autoCompleteTableBorderColor = autoCompleteTableBorderColor;
}

- (void)setAutoCompleteContentInsets:(UIEdgeInsets)autoCompleteContentInsets
{
    [self.autoCompleteTableView setContentInset:autoCompleteContentInsets];
    _autoCompleteContentInsets = autoCompleteContentInsets;
}

- (void)setAutoCompleteScrollIndicatorInsets:(UIEdgeInsets)autoCompleteScrollIndicatorInsets
{
    [self.autoCompleteTableView setScrollIndicatorInsets:autoCompleteScrollIndicatorInsets];
    _autoCompleteScrollIndicatorInsets = autoCompleteScrollIndicatorInsets;
}

- (void)resetKeyboardAutoCompleteTableFrameForNumberOfRows:(NSInteger)numberOfRows
{
    [self.autoCompleteTableView.layer setCornerRadius:0];
    
    CGRect newAutoCompleteTableViewFrame = [self autoCompleteTableViewFrameForTextField:self forNumberOfRows:numberOfRows];
    [self.autoCompleteTableView setFrame:newAutoCompleteTableViewFrame];
    
    [self.autoCompleteTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.autoCompleteTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}

- (void)resetDropDownAutoCompleteTableFrameForNumberOfRows:(NSInteger)numberOfRows
{
    [self.autoCompleteTableView.layer setCornerRadius:self.autoCompleteTableCornerRadius];
    
    CGRect newAutoCompleteTableViewFrame = [self autoCompleteTableViewFrameForTextField:self forNumberOfRows:numberOfRows];
    
    [self.autoCompleteTableView setFrame:newAutoCompleteTableViewFrame];
    [self.autoCompleteTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}

- (void)registerAutoCompleteCellNib:(UINib *)nib forCellReuseIdentifier:(NSString *)reuseIdentifier
{
    NSAssert(self.autoCompleteTableView, @"Must have an autoCompleteTableView to register cells to.");
    
    if(self.reuseIdentifier){
        [self unregisterAutoCompleteCellForReuseIdentifier:self.reuseIdentifier];
    }
    
    [self.autoCompleteTableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    [self setReuseIdentifier:reuseIdentifier];
}


- (void)registerAutoCompleteCellClass:(Class)cellClass forCellReuseIdentifier:(NSString *)reuseIdentifier
{
    NSAssert(self.autoCompleteTableView, @"Must have an autoCompleteTableView to register cells to.");
    if(self.reuseIdentifier){
        [self unregisterAutoCompleteCellForReuseIdentifier:self.reuseIdentifier];
    }
    
    BOOL classSettingSupported = NO;
    classSettingSupported = [self.autoCompleteTableView respondsToSelector:@selector(registerClass:forCellReuseIdentifier:)];
    
    NSAssert(classSettingSupported, @"Unable to set class for cell for autocomplete table, in iOS 5.0 you can set a custom NIB for a reuse identifier to get similar functionality.");
    [self.autoCompleteTableView registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
    [self setReuseIdentifier:reuseIdentifier];
}


- (void)unregisterAutoCompleteCellForReuseIdentifier:(NSString *)reuseIdentifier
{
    [self.autoCompleteTableView registerNib:nil forCellReuseIdentifier:reuseIdentifier];
}


- (void)styleAutoCompleteTableForBorderStyle:(UITextBorderStyle)borderStyle
{
    if([self.autoCompleteDelegate respondsToSelector:@selector(autoCompleteTextField:shouldStyleAutoCompleteTableView:forBorderStyle:)]){
        if(![self.autoCompleteDelegate autoCompleteTextField:self
                            shouldStyleAutoCompleteTableView:self.autoCompleteTableView
                                              forBorderStyle:borderStyle]){
            return;
        }
    }
    
    switch (borderStyle) {
        case UITextBorderStyleRoundedRect:
            [self setRoundedRectStyleForAutoCompleteTableView];
            break;
        case UITextBorderStyleBezel:
        case UITextBorderStyleLine:
            [self setLineStyleForAutoCompleteTableView];
            break;
        case UITextBorderStyleNone:
            [self setNoneStyleForAutoCompleteTableView];
            break;
        default:
            break;
    }
}

- (void)setRoundedRectStyleForAutoCompleteTableView
{
    [self setAutoCompleteTableCornerRadius:8.0];
    [self setAutoCompleteTableOriginOffset:CGSizeMake(0, -18)];
    [self setAutoCompleteScrollIndicatorInsets:UIEdgeInsetsMake(18, 0, 0, 0)];
    [self setAutoCompleteContentInsets:UIEdgeInsetsMake(18, 0, 0, 0)];
    
    if(self.backgroundColor == [UIColor clearColor]){
        [self setAutoCompleteTableBackgroundColor:[UIColor whiteColor]];
    } else {
        [self setAutoCompleteTableBackgroundColor:self.backgroundColor];
    }
}

- (void)setLineStyleForAutoCompleteTableView
{
    [self setAutoCompleteTableCornerRadius:0.0];
    [self setAutoCompleteTableOriginOffset:CGSizeZero];
    [self setAutoCompleteScrollIndicatorInsets:UIEdgeInsetsZero];
    [self setAutoCompleteContentInsets:UIEdgeInsetsZero];
    [self setAutoCompleteTableBorderWidth:1.0];
    [self setAutoCompleteTableBorderColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    
    if(self.backgroundColor == [UIColor clearColor]){
        [self setAutoCompleteTableBackgroundColor:[UIColor whiteColor]];
    } else {
        [self setAutoCompleteTableBackgroundColor:self.backgroundColor];
    }
}

- (void)setNoneStyleForAutoCompleteTableView
{
    [self setAutoCompleteTableCornerRadius:8.0];
    [self setAutoCompleteTableOriginOffset:CGSizeMake(0, 7)];
    [self setAutoCompleteScrollIndicatorInsets:UIEdgeInsetsZero];
    [self setAutoCompleteContentInsets:UIEdgeInsetsZero];
    [self setAutoCompleteTableBorderWidth:1.0];
    
    
    UIColor *lightBlueColor = [UIColor colorWithRed:181/255.0
                                              green:204/255.0
                                               blue:255/255.0
                                              alpha:1.0];
    [self setAutoCompleteTableBorderColor:lightBlueColor];
    
    
    UIColor *blueTextColor = [UIColor colorWithRed:23/255.0
                                             green:119/255.0
                                              blue:206/255.0
                                             alpha:1.0];
    [self setAutoCompleteTableCellTextColor:blueTextColor];
    
    if(self.backgroundColor == [UIColor clearColor]){
        [self setAutoCompleteTableBackgroundColor:[UIColor whiteColor]];
    } else {
        [self setAutoCompleteTableBackgroundColor:self.backgroundColor];
    }
}

- (void)saveCurrentShadowProperties
{
    [self setOriginalShadowColor:self.layer.shadowColor];
    [self setOriginalShadowOffset:self.layer.shadowOffset];
    [self setOriginalShadowOpacity:self.layer.shadowOpacity];
}

- (void)restoreOriginalShadowProperties
{
    [self.layer setShadowColor:self.originalShadowColor];
    [self.layer setShadowOffset:self.originalShadowOffset];
    [self.layer setShadowOpacity:self.originalShadowOpacity];
}

- (void)reloadData {

    if ([self.autoCompleteDataSource respondsToSelector:@selector(autoCompleteDataSourceTextField:)]) {
        
          [self autoCompleteTermsDidSort:[self.autoCompleteDataSource autoCompleteDataSourceTextField:self]];
    }
}

#pragma mark - Getters

- (BOOL)autoCompleteTableViewHidden
{
    return self.autoCompleteTableView.hidden;
}


- (void)fetchAutoCompleteSuggestions
{
    
    if(self.disableAutoCompleteTableUserInteractionWhileFetching){
        [self.autoCompleteTableView setUserInteractionEnabled:NO];
    }
    
    
    
//    [self.autoCompleteFetchQueue cancelAllOperations];
    
//    MLPAutoCompleteFetchOperation *fetchOperation = [[MLPAutoCompleteFetchOperation alloc]
//                                                     initWithDelegate:self
//                                                     completionsDataSource:self.autoCompleteDataSource
//                                                     autoCompleteTextField:self];
//    
//    [self.autoCompleteFetchQueue addOperation:fetchOperation];
}



#pragma mark - Factory Methods

- (UITableView *)newAutoCompleteTableViewForTextField:(AutoCompleteTextField *)textField
{
    CGRect dropDownTableFrame = [self autoCompleteTableViewFrameForTextField:textField];
    
    UITableView *newTableView = [[UITableView alloc] initWithFrame:dropDownTableFrame
                                                             style:UITableViewStylePlain];
    [newTableView setDelegate:textField];
    [newTableView setDataSource:textField];
    [newTableView setScrollEnabled:YES];
    [newTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    return newTableView;
}

- (CGRect)autoCompleteTableViewFrameForTextField:(AutoCompleteTextField *)textField
                                 forNumberOfRows:(NSInteger)numberOfRows
{
#if BROKEN
    // TODO: Reimplement this code for people using table views. Right now it breaks
    //       more normal use cases because of UILayoutContainerView
    CGRect newTableViewFrame             = [self autoCompleteTableViewFrameForTextField:textField];
    
    UIView *rootView                     = [textField.window.subviews objectAtIndex:0];
    CGRect textFieldFrameInContainerView = [rootView convertRect:textField.bounds
                                                        fromView:textField];
    
    CGFloat textfieldTopInset = textField.autoCompleteTableView.contentInset.top;
    CGFloat converted_originY = textFieldFrameInContainerView.origin.y + textfieldTopInset;
    
#else
    CGRect newTableViewFrame = [self autoCompleteTableViewFrameForTextField:textField];
    CGFloat textfieldTopInset = textField.autoCompleteTableView.contentInset.top;
#endif
    
    CGFloat height = [self autoCompleteTableHeightForTextField:textField withNumberOfRows:numberOfRows];
    
    newTableViewFrame.size.height = height;
#if BROKEN
    newTableViewFrame.origin.y    = converted_originY;
#endif
    
    if(!textField.autoCompleteTableAppearsAsKeyboardAccessory){
        newTableViewFrame.size.height += textfieldTopInset;
    }
    
    return newTableViewFrame;
}

- (CGFloat)autoCompleteTableHeightForTextField:(AutoCompleteTextField *)textField
                              withNumberOfRows:(NSInteger)numberOfRows
{
    CGFloat maximumHeightMultiplier = (textField.maximumNumberOfAutoCompleteRows - textField.partOfAutoCompleteRowHeightToCut);
    CGFloat heightMultiplier;
    if(numberOfRows >= textField.maximumNumberOfAutoCompleteRows){
        heightMultiplier = maximumHeightMultiplier;
    } else {
        heightMultiplier = numberOfRows;
    }
    
    CGFloat height = textField.autoCompleteRowHeight * heightMultiplier;
    return height;
}

- (CGRect)autoCompleteTableViewFrameForTextField:(AutoCompleteTextField *)textField
{
    CGRect frame = CGRectZero;
    
    if (CGRectGetWidth(self.autoCompleteTableFrame) > 0){
        frame = self.autoCompleteTableFrame;
    } else {
        frame = textField.frame;
        frame.origin.y += textField.frame.size.height;
    }
    
    frame.origin.x += textField.autoCompleteTableOriginOffset.width;
    frame.origin.y += textField.autoCompleteTableOriginOffset.height;
    frame = CGRectInset(frame, 1, 0);
    
    return frame;
}

- (NSAttributedString *)boldedString:(NSString *)string withRange:(NSRange)boldRange
{
    UIFont *boldFont = [UIFont fontWithName:self.autoCompleteBoldFontName
                                       size:self.autoCompleteFontSize];
    UIFont *regularFont = [UIFont fontWithName:self.autoCompleteRegularFontName
                                          size:self.autoCompleteFontSize];
    
    NSDictionary *boldTextAttributes = @{NSFontAttributeName : boldFont};
    NSDictionary *regularTextAttributes = @{NSFontAttributeName : regularFont};
    NSDictionary *firstAttributes;
    NSDictionary *secondAttributes;
    
    if(self.reverseAutoCompleteSuggestionsBoldEffect){
        firstAttributes = regularTextAttributes;
        secondAttributes = boldTextAttributes;
    } else {
        firstAttributes = boldTextAttributes;
        secondAttributes = regularTextAttributes;
    }
    
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:string
                                           attributes:firstAttributes];
    [attributedText setAttributes:secondAttributes range:boldRange];
    
    return attributedText;
}



@end
