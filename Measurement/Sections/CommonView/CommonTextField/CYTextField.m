//
//  CYTextField.m
//  BedsNursingApp
//
//  Created by fanjinhao on 14-6-3.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "CYTextField.h"
#import "CYTextFieldAutoFillInputView.h"
#import "NSDate+Common.h"

const NSUInteger kPreviousButtonIndex   = 0;
const NSUInteger kNextButtonIndex       = 1;

@interface CYTextFieldInternalDelegate : NSObject <UITextFieldDelegate>
@property (assign, nonatomic) id<UITextFieldDelegate> delegate;
@end

@interface CYTextField ()
@property (strong, nonatomic) CYTextFieldInternalDelegate *internalDelegate;
@property (strong, nonatomic) NSMutableArray *autoFillStrings;
@property (assign, nonatomic) BOOL resizeToolbarWhenKeyboardFrameChanges;
@property (strong, nonatomic) CYTextFieldAutoFillInputView *autoFillInputView;
@property (assign, nonatomic) CGRect autoFillInputViewFrame;
@property (assign, nonatomic) BOOL autoFillInputViewIsUndocked;
- (void)makePreviousOrNextFieldFirstResponder:(id)sender;
- (void)done:(id)sender;
@end

#pragma mark - CYTextFieldInternalDelegate

@implementation CYTextFieldInternalDelegate
@synthesize delegate;

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (nil != delegate && [delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    return (nil != textField);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (nil != delegate && [delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (nil != delegate && [delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    return (nil != textField);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (nil != delegate && [delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // If our delegate responds to this message, check its response first.
    if (nil != delegate && [delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        if (NO == [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string]) {
            return NO;
        }
    }
    
    // Either our delegate doesn't respond, or said YES.
    if ([textField isKindOfClass:[CYTextField class]]) {
        CYTextField *field = (CYTextField *)textField;
        // Check field length restriction.
        NSUInteger maxLength = [field maximumLength];
        if (maxLength > 0) {
            NSUInteger newLength = field.text.length + string.length - range.length;
            // If the string is being shortened, allow it.
            if (newLength < field.text.length)
            {
                return YES;
            }
            if (newLength > maxLength) {
                return NO;
            }
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (nil != delegate && [delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (nil != delegate && [delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    
    CYTextField *field = nil;
    if ([textField isKindOfClass:[CYTextField class]]) {
        field = (CYTextField *)textField;
    }
    if (field) {
        switch ([field returnKeyType]) {
            case UIReturnKeyNext: {
                UISegmentedControl *segControl = (UISegmentedControl *)[[field previousNextBarButtonItem] customView];
                if ([segControl isEnabledForSegmentAtIndex:kNextButtonIndex]) {
                    [segControl setSelectedSegmentIndex:kNextButtonIndex];
                    [field makePreviousOrNextFieldFirstResponder:segControl];
                }
            }
                break;
                
            case UIReturnKeyDone: {
                UIBarButtonItem *doneButton = [field doneBarButtonItem];
                if ([doneButton isEnabled]) {
                    [field done:doneButton];
                }
            }
                
            default:
                break;
        }
    }
    return YES;
}

@end

#pragma mark - CYTextField

@interface CYTextField () <UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate> {
    
    UITextField *_textField;
    
    //体温录入
    NSString *strRealNum;
    NSString *strSmallNum;
    
    //体重录入
//    NSString *strPercentile;     //百分位
//    NSString *strSmallNum;       //
//    NSString *strSmallNum;       //
    

}

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *genderPickerView;
@property (nonatomic , strong)UIPickerView *normalPickerView;   //表示正常的选择
@property (nonatomic , strong)UIPickerView *bodyTempPickerView;      //表示体温录入选择器
@property (nonatomic , strong)UIPickerView *bodyTempTypePickerView;  //表示体温类型录入选择器
@property (nonatomic , strong)UIPickerView *bodyWeightTypePickerView; //表示体重输入类型

@end

@implementation CYTextField

@synthesize previousField = _previousField;
@synthesize nextField = _nextField;
@synthesize inputAccessoryViewHidden = _inputAccessoryViewHidden;
@synthesize previousNextBarButtonItem = _previousNextBarButtonItem;
@synthesize autoFillDataSource = _autoFillDataSource;
@synthesize autoFillBarButtonItem = _autoFillBarButtonItem;
@synthesize autoFillBarButtonHidden = _autoFillBarButtonHidden;
@synthesize autoFillBarButtonEnabled = _autoFillBarButtonEnabled;
@synthesize autoFillInputViewFrame = _autoFillInputViewFrame;
@synthesize autoFillInputViewIsUndocked = _autoFillInputViewIsUndocked;
@synthesize doneBarButtonItem = _doneBarButtonItem;
@synthesize doneBarButtonHidden = _doneBarButtonHidden;
@synthesize resizeToolbarWhenKeyboardFrameChanges = _resizeToolbarWhenKeyboardFrameChanges;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureControl];
         [self setup];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self configureControl];
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureControl];
         [self setup];
    }
    return self;
}


- (void)configureControl {
    // Always have an internal delegate.
    [self installInternalDelegate:nil];
    
    // Set option defaults.
    [self setInputAccessoryViewHidden:NO];
    [self setAllowSwipeToDismissKeyboard:YES];
    [self setPresentAutoFillAnimationDuration:0.2];
    [self setDismissAutoFillAnimationDuration:0.15];
}

- (void)setPreviousField:(UIResponder *)previousField {
    _previousField = previousField;
    [self updateToolbarAnimated:NO];
    [self updatePreviousNextButtons];
}

- (void)setNextField:(UIResponder *)nextField {
    _nextField = nextField;
    [self updateToolbarAnimated:NO];
    [self updatePreviousNextButtons];
}

#pragma mark - Internal delegate

- (void)installInternalDelegate:(CYTextFieldInternalDelegate *)delegate {
    // If an internal delegate is already set, replace it.
    if (nil != [self internalDelegate] && (nil != delegate)) {
        if (nil != [[self internalDelegate] delegate]) {
            [delegate setDelegate:[[self internalDelegate] delegate]];
        }
        [self setInternalDelegate:delegate];
    }
    // If no internal delegate is set, create one.
    if (nil == [self internalDelegate]) {
        [self setInternalDelegate:(nil != delegate ? delegate : [[CYTextFieldInternalDelegate alloc] init])];
    }
    [super setDelegate:[self internalDelegate]];
}

- (id<UITextFieldDelegate>)delegate {
    [self installInternalDelegate:nil];
    return [super delegate];
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    if ([delegate isKindOfClass:[CYTextFieldInternalDelegate class]]) {
        [self installInternalDelegate:delegate];
    } else {
        [self installInternalDelegate:nil];
        [[self internalDelegate] setDelegate:delegate];
    }
}

- (id<UITextFieldDelegate>)customDelegate {
    return [[self internalDelegate] delegate];
}

#pragma mark - Responder status

- (BOOL)becomeFirstResponder {
    // Resize the toolbar if we are going to become the first responder, but
    // make sure to do it after [super becomeFirstResponder]
    BOOL result;
    if ([self canBecomeFirstResponder]) {
        
        [self setNotificationsEnabled:YES];
        result = [super becomeFirstResponder];
        if (result) {
            if (![self inputAccessoryViewHidden]) {
                [self setResizeToolbarWhenKeyboardFrameChanges:YES];
            }
            // Initialize auto-fill.
            [self queryAutoFillDataSource];
        } else {
            [self setNotificationsEnabled:NO];
        }
        return result;
    }
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    if ([self canResignFirstResponder]) {
        [self setResizeToolbarWhenKeyboardFrameChanges:NO];
        
        [self setNotificationsEnabled:NO];
        
        // If the autofill view is shown, remove it.
        if (nil != [self autoFillInputView]) {
            [self dismissAutoFillInputView];
        }
    }
    return [super resignFirstResponder];
}

#pragma mark - Toolbar

- (void)installToolbar {
    if (nil == [self inputAccessoryView]) {
        UIToolbar *toolbar = [[UIToolbar alloc] init];
        // Customize toolbar appearance to match keyboard.
        [toolbar setBarStyle:[self barStyleMatchingKeyboard]];
        [self setInputAccessoryView:toolbar];
        [toolbar sizeToFit];
        // Add swipe gesture recognizer.
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedKeyboard:)];
        [swipe setDirection:UISwipeGestureRecognizerDirectionDown];
        [toolbar addGestureRecognizer:swipe];
        [self updateToolbarAnimated:NO];
    }
}

- (void)swipedKeyboard:(id)sender {
    if ([self allowSwipeToDismissKeyboard]) {
        [self done:sender];
    }
}

- (void)updateToolbarAnimated:(BOOL)animated {
    if ([self inputAccessoryViewHidden]) return;
    
    NSMutableArray *barItems = [NSMutableArray array];
    
    if (nil == [self autoFillInputView]) {
        // Standard configuration.
        
        // Previous|Next buttons
        UIBarButtonItem *barItem = [self previousNextBarButtonItem];
        if (nil != barItem) {
            [barItems addObject:barItem];
        }
        
        // AutoFill button
        if (nil != [self autoFillDataSource]) {
            if ([barItems count] > 0) {
                [barItems addObject:[self flexibleSpaceBarButtonItem]];
            }
            [barItems addObject:[self autoFillBarButtonItem]];
        }
        
        // Done button
        if (NO == [self doneBarButtonHidden]) {
            [barItems addObjectsFromArray:@[[self flexibleSpaceBarButtonItem], [self doneBarButtonItem]]];
        }
    } else {
        // Auto-fill configuration.
        [barItems addObjectsFromArray:@[[self flexibleSpaceBarButtonItem],
                                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAutoFill:)]]];
    }
    
    [[self toolbar] setItems:barItems animated:animated];
}

- (UIBarStyle)barStyleMatchingKeyboard {
    if (UIUserInterfaceIdiomPhone == UI_USER_INTERFACE_IDIOM()) {
        if (UIKeyboardAppearanceAlert == [self keyboardAppearance]) {
            return UIBarStyleBlackTranslucent;
        }
    }
    return UIBarStyleDefault;
}

- (UIToolbar *)toolbar {
    return (UIToolbar *)[self inputAccessoryView];
}

- (CGFloat)toolbarHeight {
    if (nil != [self toolbar]) {
        return CGRectGetHeight([[self toolbar] frame]);
    }
    return 0;
}

- (void)setInputAccessoryViewHidden:(BOOL)inputAccessoryViewHidden {
    _inputAccessoryViewHidden = inputAccessoryViewHidden;
    if (_inputAccessoryViewHidden) {
        [self setInputAccessoryView:nil];
    } else {
        [self installToolbar];
    }
    [self setResizeToolbarWhenKeyboardFrameChanges:!_inputAccessoryViewHidden];
}

- (void)setResizeToolbarWhenKeyboardFrameChanges:(BOOL)resizeToolbarWhenKeyboardFrameChanges {
    _resizeToolbarWhenKeyboardFrameChanges = resizeToolbarWhenKeyboardFrameChanges;
    if (_resizeToolbarWhenKeyboardFrameChanges) {
       // [[NSNotificationCenter defaultCenter] addObserver:self.toolbar selector:@selector(sizeToFit) name:UIKeyboardDidChangeFrameNotification object:nil];
        [[self toolbar] sizeToFit];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self.toolbar name:UIKeyboardDidChangeFrameNotification object:nil];
    }
}

- (UIBarButtonItem *)flexibleSpaceBarButtonItem {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

#pragma mark - Previous|Next toolbar buttons and functionality

- (BOOL)previousBarButtonEnabled {
    if (nil != _previousNextBarButtonItem) {
        UISegmentedControl *segControl = (UISegmentedControl *)[_previousNextBarButtonItem customView];
        return [segControl isEnabledForSegmentAtIndex:kPreviousButtonIndex];
    }
    return NO;
}

- (void)setPreviousBarButtonEnabled:(BOOL)previousBarButtonEnabled {
    if (nil != _previousNextBarButtonItem) {
        previousBarButtonEnabled = (previousBarButtonEnabled && (nil != self.previousField));
        UISegmentedControl *segControl = (UISegmentedControl *)[_previousNextBarButtonItem customView];
        [segControl setEnabled:previousBarButtonEnabled forSegmentAtIndex:kPreviousButtonIndex];
    }
}

- (BOOL)nextBarButtonEnabled {
    if (nil != _previousNextBarButtonItem) {
        UISegmentedControl *segControl = (UISegmentedControl *)[_previousNextBarButtonItem customView];
        return [segControl isEnabledForSegmentAtIndex:kNextButtonIndex];
    }
    return NO;
}

- (void)setNextBarButtonEnabled:(BOOL)nextBarButtonEnabled {
    if (nil != _previousNextBarButtonItem) {
        nextBarButtonEnabled = (nextBarButtonEnabled && (nil != self.nextField));
        UISegmentedControl *segControl = (UISegmentedControl *)[_previousNextBarButtonItem customView];
        [segControl setEnabled:nextBarButtonEnabled forSegmentAtIndex:kNextButtonIndex];
    }
}

- (UIBarButtonItem *)previousNextBarButtonItem {
    if (nil == _previousNextBarButtonItem) {
        // Only instantiate if this field has siblings.
        if (nil != self.previousField || nil != self.nextField) {
            // Create a segmented control with two segments (Previous|Next) as
            // the custom view for the bar button item.
            UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"上一项", @"下一项"]];
            [segControl setMomentary:YES];
            [segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
            [segControl addTarget:self action:@selector(makePreviousOrNextFieldFirstResponder:) forControlEvents:UIControlEventValueChanged];
            _previousNextBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:segControl];
            [self updatePreviousNextButtons];
        }
    }
    return _previousNextBarButtonItem;
}

// Enable/disable the segments based on presence of sibling fields.
- (void)updatePreviousNextButtons {
    UISegmentedControl *segControl = (UISegmentedControl *)[[self previousNextBarButtonItem] customView];
    if (nil == segControl) return;
    
    [segControl setEnabled:(nil != [self previousField]) forSegmentAtIndex:kPreviousButtonIndex];
    [segControl setEnabled:(nil != [self nextField]) forSegmentAtIndex:kNextButtonIndex];
}

- (void)makePreviousOrNextFieldFirstResponder:(id)sender {
    // Respond only to our previous|next segmented control.
    UISegmentedControl *segControl = (UISegmentedControl *)[self.previousNextBarButtonItem customView];
    if (sender == segControl) {
        // The seg control's selected index determines previous or next.
        switch ([segControl selectedSegmentIndex]) {
            case kPreviousButtonIndex:
                [self makeFieldFirstResponder:self.previousField];
                break;
                
            case kNextButtonIndex:
                [self makeFieldFirstResponder:self.nextField];
                break;
        }
        [segControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }
}

- (void)makeFieldFirstResponder:(UIResponder *)aField {
    if (nil == aField) return;
    if ([self canResignFirstResponder] && [aField canBecomeFirstResponder]) {
        [aField becomeFirstResponder];
    }
}

#pragma mark - Auto-fill toolbar button and functionality

- (UIBarButtonItem *)autoFillBarButtonItem {
    if (nil == _autoFillBarButtonItem) {
        _autoFillBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"AutoFill" style:UIBarButtonItemStyleBordered target:self action:@selector(autoFill:)];
    }
    return _autoFillBarButtonItem;
}

- (BOOL)autoFillBarButtonHidden {
    if (nil == _autoFillDataSource) return YES;
    return _autoFillBarButtonHidden;
}

- (void)setAutoFillBarButtonHidden:(BOOL)autoFillBarButtonHidden {
    if (nil == _autoFillDataSource) return;
    _autoFillBarButtonHidden = autoFillBarButtonHidden;
    [self updateToolbarAnimated:YES];
}

- (BOOL)autoFillBarButtonEnabled {
    if (nil == _autoFillDataSource) return NO;
    if ([self autoFillBarButtonHidden]) return NO;
    return [[self autoFillBarButtonItem] isEnabled];
}

- (void)setAutoFillBarButtonEnabled:(BOOL)autoFillBarButtonEnabled {
    if (nil == _autoFillDataSource) return;
    [_autoFillBarButtonItem setEnabled:autoFillBarButtonEnabled];
    if (autoFillBarButtonEnabled) {
        [self updateAutoFillBarButtonItemEnabledState];
    }
}

- (void)setAutoFillDataSource:(id<CYTextFieldAutoFillDataSource>)autoFillDataSource {
    _autoFillDataSource = autoFillDataSource;
    if (nil != _autoFillDataSource && nil == _autoFillStrings) {
        _autoFillStrings = [[NSMutableArray alloc] init];
    }
    [self queryAutoFillDataSource];
}

- (void)queryAutoFillDataSource {
    if (nil == _autoFillDataSource && nil != _autoFillStrings) {
        [_autoFillStrings removeAllObjects];
        _autoFillStrings = nil;
    } else {
        // Reset strings.
        [_autoFillStrings removeAllObjects];
        
        // See if we have enough characters to query the data source.
        NSUInteger minChars = 0;
        if ([_autoFillDataSource respondsToSelector:@selector(minimumLengthForAutoFillQueryForTextField:)]) {
            minChars = [_autoFillDataSource minimumLengthForAutoFillQueryForTextField:self];
        }
        
        NSString *string = [[self text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (nil != string && [string length] >= minChars) {
            [_autoFillStrings addObjectsFromArray:[self filterAutoFillStrings:[_autoFillDataSource textField:self autoFillStringsForString:string]]];
        } else {
            [_autoFillStrings removeAllObjects];
        }
    }
    
    [self updateAutoFillBarButtonItemEnabledState];
}

- (NSArray *)filterAutoFillStrings:(NSArray *)strings {
    NSMutableArray *filtered = [[NSMutableArray alloc] init];
    for (NSString *string in strings) {
        NSString *filteredString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (NO == [filtered containsObject:filteredString]) {
            // If the field has a max length restriction, do not allow strings
            // that are too long.
            if (([self maximumLength] < 1) || ([filteredString length] <= [self maximumLength])) {
                [filtered addObject:filteredString];
            }
        }
    }
    return filtered;
}

- (void)updateAutoFillBarButtonItemEnabledState {
    // If there is only one matching auto-fill string, and its an exact match
    // with the text already entered, then disable the AutoFill button.
    if (1 == [_autoFillStrings count]) {
        NSString *string = [_autoFillStrings lastObject];
        [_autoFillBarButtonItem setEnabled:(!(NSOrderedSame == [[self text] compare:string options:NSCaseInsensitiveSearch]))];
    } else {
        [_autoFillBarButtonItem setEnabled:([_autoFillStrings count] > 0)];
    }
}

- (void)autoFill:(id)sender {
    // If there is only one auto-fill string match, then simply apply it.
    if (1 == [_autoFillStrings count]) {
        [self applyAutoFillString:[_autoFillStrings lastObject]];
        // Do not allow the same string to be continually auto-filled.
        [_autoFillBarButtonItem setEnabled:NO];
    } else {
        [self presentAutoFillInputView];
    }
}

- (void)applyAutoFillString:(NSString *)string {
    [self setText:string];
    
    [[UIDevice currentDevice] playInputClick];
    
    // We seem to have to post this notification manually.
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self userInfo:nil];
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    
    // Close the auto-fill input view if presented.
    if (nil != [self inputView]) {
        [self cancelAutoFill:self];
    }
    
    if ([self textFieldShouldReturnAfterAutoFill]) {
        [self.internalDelegate textFieldShouldReturn:self];
    } else {
        [self queryAutoFillDataSource];
    }
}

- (void)presentAutoFillInputView {
    if (nil == [self autoFillInputView]) {
        [self setAutoFillInputView:[[CYTextFieldAutoFillInputView alloc] initWithFrame:[self autoFillInputViewFrame]]];
        if (_autoFillInputViewIsUndocked) {
            [[self autoFillInputView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        } else {
            [[self autoFillInputView] setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
        }
        [[self autoFillInputView] presentForTextField:self];
        [self updateToolbarAnimated:YES];
    }
}

- (void)dismissAutoFillInputView {
    [[self autoFillInputView] dismiss];
    _autoFillInputView = nil;
    [self updateToolbarAnimated:YES];
    // Re-query data source, since it is editable - all items may have been
    // removed.
    [self queryAutoFillDataSource];
}

- (void)cancelAutoFill:(id)sender {
    [self dismissAutoFillInputView];
}

- (void)removeAutoFillString:(NSString *)string {
    [[self autoFillStrings] removeObject:string];
    // If we removed all items, cancel auto fill.
    if (([[self autoFillStrings] count] < 1) &&
        (nil != [self autoFillInputView])) {
        [self dismissAutoFillInputView];
    }
}

#pragma mark - Done toolbar button and functionality

- (UIBarButtonItem *)doneBarButtonItem {
    if (nil == _doneBarButtonItem) {
        _doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    }
    return _doneBarButtonItem;
}

- (void)setDoneBarButtonHidden:(BOOL)doneBarButtonHidden {
    _doneBarButtonHidden = doneBarButtonHidden;
    [self updateToolbarAnimated:YES];
}

- (BOOL)doneBarButtonEnabled {
    return [[self doneBarButtonItem] isEnabled];
}

- (void)setDoneBarButtonEnabled:(BOOL)doneBarButtonEnabled {
    [[self doneBarButtonItem] setEnabled:doneBarButtonEnabled];
}

- (void)done:(id)sender {
    [self resignFirstResponder];
}
/**
 *  xhtextfield
 *
 *  @return
 */
- (void)setup
{
    strRealNum = @"37";
    strSmallNum = @"0";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CYtextFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
}
- (void)CYtextFieldDidBeginEditing:(NSNotification *) notification
{
    UITextField *textField = (UITextField*)[notification object];

    [self selectInputView:textField];

}
- (void)setM_textFieldType:(CYTextFieldType)fieldType {
    _m_textFieldType = fieldType;
}
#pragma mark - Notifications

- (void)setNotificationsEnabled:(BOOL)enabled {
    if (enabled) {
        // Set up notifications.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    } else {
        // Stop receiving notifications.
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    }
}

- (void)textDidChange:(NSNotification *)notification {
    if (nil != [self autoFillInputView]) {
        [self dismissAutoFillInputView];
    }
    [self queryAutoFillDataSource];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    // Keep the autoFillInputViewFrame up to date.
    
    // The iPad doesn't send UIKeyboardDidShow notifications when the keyboard
    // is undocked. So this method seems the best way to get the keyboard's
    // current frame, on both iPad and iPhone.
    
    // We also cannot always reliably tell the device orientation (at least,
    // not on the simulator). So we will figure it out from the frame and screen
    // dimensions.
    
    // Get all of the measurements we need.
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGRect frameEnd;
    [[notification userInfo][UIKeyboardFrameEndUserInfoKey] getValue:&frameEnd];
    CGFloat toolbarHeight = [self toolbarHeight];
    
    // Determine orientation by comparing frameEndSize to screenSize.
    BOOL orientationIsPortrait = (frameEnd.size.width == screenSize.width);
    // The keyboard is always docked on the iPhone.
    BOOL keyboardIsUndocked = NO;
    
    // Check for undocked keyboard on iPad
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        if (frameEnd.origin.x > 0 || frameEnd.origin.y > 0) {
            if (orientationIsPortrait) {
                keyboardIsUndocked = ((frameEnd.origin.y + frameEnd.size.height) < screenSize.height);
            } else {
                keyboardIsUndocked = ((frameEnd.origin.x + frameEnd.size.width) < screenSize.width);
            }
        }
    }
    
    // Determine state.
    if (orientationIsPortrait) {
        [self setAutoFillInputViewFrame:CGRectMake(0, 0, frameEnd.size.width, frameEnd.size.height - toolbarHeight)];
    } else {
        [self setAutoFillInputViewFrame:CGRectMake(0, 0, frameEnd.size.height, frameEnd.size.width - toolbarHeight)];
    }
    [self setAutoFillInputViewIsUndocked:keyboardIsUndocked];
}

- (void)setAutoFillInputViewFrame:(CGRect)autoFillInputViewFrame {
    _autoFillInputViewFrame = autoFillInputViewFrame;
    // Do not update the auto fill input view frame while it is displayed.
}

- (void)setAutoFillInputViewIsUndocked:(BOOL)autoFillInputViewIsUndocked {
    _autoFillInputViewIsUndocked = autoFillInputViewIsUndocked;
    if (nil != [self autoFillInputView]) {
        if (_autoFillInputViewIsUndocked) {
            [[self autoFillInputView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        } else {
            [[self autoFillInputView] setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
        }
    }
}

//


- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//        [_dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
//        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    return _dateFormatter;
}


- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeTime;
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (UIPickerView *)genderPickerView {
    if (!_genderPickerView) {
        _genderPickerView = [[UIPickerView alloc] init];
        _genderPickerView.delegate = self;
        _genderPickerView.dataSource = self;
    }
    return _genderPickerView;
}
//bodyTempPickerView
- (UIPickerView *)bodyTempPickerView {
    if (!_bodyTempPickerView) {
        _bodyTempPickerView = [[UIPickerView alloc] init];
        _bodyTempPickerView.delegate = self;
        _bodyTempPickerView.dataSource = self;
    }
    return _bodyTempPickerView;
}
//normalPickerView
-(UIPickerView *)normalPickerView{
    if (!_normalPickerView) {
        _normalPickerView = [[UIPickerView alloc] init];
        _normalPickerView.delegate = self;
        _normalPickerView.dataSource = self;
    }
    return _normalPickerView;

    
}
//bodyTempTypePickerView
- (UIPickerView *)bodyTempTypePickerView {
    if (!_bodyTempTypePickerView) {
        _bodyTempTypePickerView = [[UIPickerView alloc] init];
        _bodyTempTypePickerView.delegate = self;
        _bodyTempTypePickerView.dataSource = self;
    }
    return _bodyTempTypePickerView;
}

//bodyWeightTypePickerView
- (UIPickerView *)bodyWeightTypePickerView {
    if (!_bodyWeightTypePickerView) {
        _bodyWeightTypePickerView = [[UIPickerView alloc] init];
        _bodyWeightTypePickerView.delegate = self;
        _bodyWeightTypePickerView.dataSource = self;
    }
    return _bodyWeightTypePickerView;
}


#pragma mark - UITextField inputView help

- (void)selectInputView:(UITextField *)textField
{
    if (self.m_textFieldType == CYDateTextField) {
        if ([textField.text isEqualToString:@""]){
            NSDate *mydate = [NSDate new];
            [self.datePicker setDate:mydate];
            
        }else
        {
            NSDate *mydate = [NSDate GetDateWithDateStr:textField.text];
            [self.datePicker setDate:mydate];
        }
        [textField setInputView:self.datePicker];
    } else if (self.m_textFieldType == CYDateTextField) {
        [textField setInputView:self.datePicker];
    } else if (self.m_textFieldType == CYbodyTempTypeTextField) {
        [textField setInputView:self.bodyTempTypePickerView];
    }else if (self.m_textFieldType == CYbodyTempTextField) {
        [textField setInputView:self.bodyTempPickerView];
    }else if(self.m_textFieldType == CYNormalPickerTextField)
    {
        [textField setInputView:self.normalPickerView];
    }
    
}

- (void)datePickerValueChanged:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    
    NSDate *selectedDate = datePicker.date;
    
    [self setText:[self.dateFormatter stringFromDate:selectedDate]];
    
    if ([self.cyDelegate respondsToSelector:@selector(dateChangedWithDate:)]) {
        [self.cyDelegate dateChangedWithDate:datePicker.date];
    }
    
    //[self validate];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return self.m_pVDataSourceDict.allKeys.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    

    //1 先取到字典中所有key的值数组
    NSArray *allkeys = self.m_pVDataSourceDict.allKeys;
    //说明数组越界
    if (allkeys.count < component) {
        return 0;
    }
    //2然后得道对应component的key的值为找NSArray做准备
    NSString *valueKey = allkeys[component];
    //3然后通过valueKey找到对应的数组
    NSArray *values = self.m_pVDataSourceDict[valueKey];
    
    //4返回数组的元素个数
    return values.count;
}

#pragma mark - UIPickerViewDelegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //1 先取到字典中所有key的值数组
    NSArray *allkeys = self.m_pVDataSourceDict.allKeys;
    //2然后得道对应component的key的值为找NSArray做准备
    NSString *valueKey = allkeys[component];
    //3然后通过valueKey找到对应的数组
    NSArray *values = self.m_pVDataSourceDict[valueKey];
    
    //说明数组越界
    if (values.count < row) {
        return @"";
    }
    
    return values[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //1 先取到字典中所有key的值数组
    NSArray *allkeys = self.m_pVDataSourceDict.allKeys;
    //2然后得道对应component的key的值为找NSArray做准备
    NSString *valueKey = allkeys[component];
    //3然后通过valueKey找到对应的数组
    NSArray *values = self.m_pVDataSourceDict[valueKey];
    
    
    //表示体温录入
    if (pickerView == self.bodyTempPickerView)
    {
      
        switch (component) {
            case 0:
            {
                strRealNum = [[self.m_pVDataSourceDict objectForKey:@"RealNum"] objectAtIndex:row];
                ;
                break;
            }
            case 1:
            {
                strSmallNum = [[self.m_pVDataSourceDict objectForKey:@"SanllNum"]objectAtIndex:row];
                ;
                break;
            }
            default:
                break;
        }
        
        NSString *resultStr = [NSString stringWithFormat:@"%@.%@",strRealNum,strSmallNum];
        
        
        
        self.text = [NSString stringWithFormat:@"%@",resultStr];
    }else if (pickerView == self.bodyTempTypePickerView) //表示体温类型录入
    {
        self.text = [NSString stringWithFormat:@"%@",values[row]];
    }else if(pickerView == self.bodyWeightTypePickerView) //表示体重类型录入
    {
        
        
        switch (component) {
            case 0:
            {
                strRealNum = [[self.m_pVDataSourceDict objectForKey:@"SanllNum"] objectAtIndex:row];
                ;
                break;
            }
            case 1:
            {
                strSmallNum = [[self.m_pVDataSourceDict objectForKey:@"SanllNum"]objectAtIndex:row];
                ;
                break;
            }
            case 2:
            {
                strSmallNum = [[self.m_pVDataSourceDict objectForKey:@"SanllNum"]objectAtIndex:row];
                ;
                break;
            }
            default:
                break;
        }
        
        NSString *resultStr = [NSString stringWithFormat:@"%@.%@",strRealNum,strSmallNum];
        
        self.text = resultStr;
  
    }else if(pickerView == self.normalPickerView) //表示正常的选择
    {
        self.text = [NSString stringWithFormat:@"%@",self.m_pVDataSourceDict[@"SanllNum"][row]];
        
    }
    
    
    

    
    
    
    
    
    
    
    
}
//- (void)_chanegConstellation:(NSDate *)date {
//    NSInteger tagIndex = self.tag;
//    XHTextField *textField =  [self.textFields objectAtIndex:++tagIndex];
//    textField.text = [XHTextField getConstellation:date];
//}



/**
 *  验证textfield的数据
 *
 *  @return 返回yes则符合
 */
- (BOOL)validate
{
    self.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5];
    
    if (self.m_required && ![self.text length]) {
        return NO;
    }
    else if (self.m_textFieldType == CYEmailTextField) {
        NSString *emailRegEx =
        @"(?:[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}"
        @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-"
        @"z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5"
        @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        @"9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
        
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if (![emailTest evaluateWithObject:self.text]){
            return NO;
        }
    } else if ([self.text length] > self.maxTextLength) {
        return NO;
    }
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    return YES;

}

/**
 *  更具选择的时间返回时间点
 *
 *  @param date 传入选择的时间
 *
 *  @return 时间点
 */
+ (NSString *)getPointInTime:(NSDate *)date
{
    
    
    
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
