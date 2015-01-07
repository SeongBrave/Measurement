//
//  DropDownTextField.m
//  scrollView
//
//  Created by DTSoft on 15/1/6.
//  Copyright (c) 2015年 山西金仕达软件有限公司. All rights reserved.
//

#import "DropDownTextField.h"


static NSString *DropDownTextFieldCellIdentifier = @"_DropDownTextFieldCellIdentifier";


@interface DropDownTextField ()

@property (strong, readwrite) UITableView *dropDownTableView;
@property (strong) NSArray *dropDowSuggestions;
@property (strong) NSOperationQueue *dropDowSortQueue;
@property (strong) NSOperationQueue *dropDowFetchQueue;
@property (strong) NSString *reuseIdentifier;
@property (assign) CGColorRef originalShadowColor;
@property (assign) CGSize originalShadowOffset;
@property (assign) CGFloat originalShadowOpacity;
@property(nonatomic , strong)UIButton *leftBtn;

@end
@implementation DropDownTextField


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

- (void)initialize
{
    
    /**
     添加右侧的btn
     */
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"general-arrow-down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"general-arrow-up"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    //uibutton视图的布局
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.trailing.equalTo(self.mas_trailing).offset(-5); //设置中线视图
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.height.equalTo(@16);
        
        make.width.equalTo(@28);
        
    }];
    self.leftBtn = btn;
    
    [self setDefaultValuesForVariables];
    
    UITableView *newTableView = [self newdropDowTableViewForTextField:self];
    
    self.dropDownTableView = newTableView;
    
    [self styleDropDowTableForBorderStyle:self.borderStyle];
    
    
}

/**
 *  初始化一些数据
 */
- (void)setDefaultValuesForVariables
{
    [self setClipsToBounds:NO];
    
    [self setDropDowRowHeight:35];
    [self setDropDownFontSize:13];
    
    [self setDropDownTableCellBackgroundColor:[UIColor whiteColor]];
}


-(void)loadDropDownTableView
{
    [self.dropDownTableView setAlpha:1];
    
    [self.superview bringSubviewToFront:self];
#if BROKEN
    UIView *rootView = [self.window.subviews objectAtIndex:0];
    [rootView insertSubview:self.autoCompleteTableView
               belowSubview:self];
#else
    [self.superview insertSubview:self.dropDownTableView
                     belowSubview:self];
#endif
    [self.dropDownTableView setUserInteractionEnabled:YES];
   
    [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.layer setShadowOffset:CGSizeMake(0, 1)];
    [self.layer setShadowOpacity:0.35];
  
      [self.dropDownTableView.layer setCornerRadius:self.dropDownTableCornerRadius];
    [self.dropDownTableView setContentInset:self.dropDownContentInsets];
    [self.dropDownTableView setScrollIndicatorInsets:self.dropDownScrollIndicatorInsets];
    [self.dropDownTableView reloadData];
}

-(void)btnClick:(UIButton *) btn
{
    if (btn.selected) {
         [self hideDropDownTableView];
    }else
    {
        [self showDropDownTableView];
    }

    [self loadDropDownTableView];
}
/**
 *  显示DropDownTableView
 */
-(void)showDropDownTableView
{
    self.leftBtn.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame=self.dropDownTableView.frame;
        
        frame.size.height=150;
        [self.dropDownTableView setFrame:frame];
        
    } completion:^(BOOL finished){
        
        
    }];
}

/**
 *  隐藏DropDownTableView
 */
-(void)hideDropDownTableView
{
    self.leftBtn.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame=self.dropDownTableView.frame;
        
        frame.size.height=1;
        [self.dropDownTableView setFrame:frame];
        
    } completion:^(BOOL finished){
        
        [self closeDropDowTableView];
        
    }];
 
}


- (void)closeDropDowTableView
{
    [self.dropDownTableView removeFromSuperview];
    [self restoreOriginalShadowProperties];
}

- (void)styleDropDowTableForBorderStyle:(UITextBorderStyle)borderStyle
{
    switch (borderStyle) {
        case UITextBorderStyleRoundedRect:
            [self setRoundedRectStyleForDropDowTableView];
            break;
        case UITextBorderStyleBezel:
        case UITextBorderStyleLine:
            [self setLineStyleForDropDowTableView];
            break;
        case UITextBorderStyleNone:
            [self setNoneStyleForDropDowTableView];
            break;
        default:
            break;
    }
}

- (void)setRoundedRectStyleForDropDowTableView
{

    [self setDropDownTableCornerRadius:8.0];
    [self setDropDownTableOriginOffset:CGSizeMake(0, -18)];

    [self setDropDownScrollIndicatorInsets:UIEdgeInsetsMake(18, 0, 0, 0)];
    [self setDropDownContentInsets:UIEdgeInsetsMake(18, 0, 0, 0)];
    
    if(self.backgroundColor == [UIColor clearColor]){
        [self setDropDownTableBackgroundColor:[UIColor colorWithRed:1.000 green:0.603 blue:0.492 alpha:1.000]];
    } else {
//        [self setDropDownTableBackgroundColor:self.backgroundColor];
    }
}

- (void)setLineStyleForDropDowTableView
{
    [self setDropDownTableCornerRadius:0.0];
    [self setDropDownTableOriginOffset:CGSizeZero];
    [self setDropDownScrollIndicatorInsets:UIEdgeInsetsZero];
    [self setDropDownContentInsets:UIEdgeInsetsZero];
    [self setDropDownTableBorderWidth:1.0];
    [self setDropDownTableBorderColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    
    if(self.backgroundColor == [UIColor clearColor]){
        [self setDropDownTableBackgroundColor:[UIColor whiteColor]];
    } else {
        [self setDropDownTableBackgroundColor:self.backgroundColor];
    }
}

- (void)setNoneStyleForDropDowTableView
{
    [self setDropDownTableCornerRadius:8.0];
    [self setDropDownTableOriginOffset:CGSizeMake(0, 7)];
    [self setDropDownScrollIndicatorInsets:UIEdgeInsetsZero];
    [self setDropDownContentInsets:UIEdgeInsetsZero];
    [self setDropDownTableBorderWidth:1.0];
    
    
    UIColor *lightBlueColor = [UIColor colorWithRed:181/255.0
                                              green:204/255.0
                                               blue:255/255.0
                                              alpha:1.0];
    [self setDropDownTableBorderColor:lightBlueColor];
    
    
    UIColor *blueTextColor = [UIColor colorWithRed:23/255.0
                                             green:119/255.0
                                              blue:206/255.0
                                             alpha:1.0];
    [self setDropDownTableCellTextColor:blueTextColor];
    
    if(self.backgroundColor == [UIColor clearColor]){
        [self setDropDownTableBackgroundColor:[UIColor whiteColor]];
    } else {
        [self setDropDownTableBackgroundColor:self.backgroundColor];
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



- (void)setDropDownTableBorderWidth:(CGFloat)autoCompleteTableBorderWidth
{
    [self.dropDownTableView.layer setBorderWidth:autoCompleteTableBorderWidth];
    _dropDownTableBorderWidth = autoCompleteTableBorderWidth;
}

- (void)setDropDownScrollTableBorderColor:(UIColor *)autoCompleteTableBorderColor
{
    [self.dropDownTableView.layer setBorderColor:[autoCompleteTableBorderColor CGColor]];
    _dropDownTableBorderColor = autoCompleteTableBorderColor;
}

- (void)setDropDownScrollContentInsets:(UIEdgeInsets)autoCompleteContentInsets
{
    [self.dropDownTableView setContentInset:autoCompleteContentInsets];
    _dropDownContentInsets = autoCompleteContentInsets;
}

- (void)setDropDownScrollIndicatorInsets:(UIEdgeInsets)autoCompleteScrollIndicatorInsets
{
    [self.dropDownTableView setScrollIndicatorInsets:autoCompleteScrollIndicatorInsets];
    _dropDownScrollIndicatorInsets = autoCompleteScrollIndicatorInsets;
}


- (void)registerDropDownCellNib:(UINib *)nib forCellReuseIdentifier:(NSString *)reuseIdentifier
{
    
    if(self.reuseIdentifier){
        [self unregisterAutoCompleteCellForReuseIdentifier:self.reuseIdentifier];
    }
    
    [self.dropDownTableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    
    [self setReuseIdentifier:reuseIdentifier];
    
}

- (void)registerDropDownCellClass:(Class)cellClass forCellReuseIdentifier:(NSString *)reuseIdentifier
{
    
    if(self.reuseIdentifier){
        [self unregisterAutoCompleteCellForReuseIdentifier:self.reuseIdentifier];
    }
    
  
    
    BOOL classSettingSupported = NO;
    classSettingSupported = [self.dropDownTableView respondsToSelector:@selector(registerClass:forCellReuseIdentifier:)];
    
    NSAssert(classSettingSupported, @"Unable to set class for cell for autocomplete table, in iOS 5.0 you can set a custom NIB for a reuse identifier to get similar functionality.");
     [self.dropDownTableView registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
    [self setReuseIdentifier:reuseIdentifier];
}

- (void)unregisterAutoCompleteCellForReuseIdentifier:(NSString *)reuseIdentifier
{
    [self.dropDownTableView registerNib:nil forCellReuseIdentifier:reuseIdentifier];
}
#pragma mark - Factory Methods

- (UITableView *)newdropDowTableViewForTextField:(DropDownTextField *)textField
{
    CGRect dropDownTableFrame = [self dropDowTableViewFrameForTextField:textField];
    
    UITableView *newTableView = [[UITableView alloc] initWithFrame:dropDownTableFrame
                                                             style:UITableViewStylePlain];
    [newTableView setDelegate:textField];
    [newTableView setDataSource:textField];
    [newTableView setScrollEnabled:YES];
//    newTableView.backgroundColor = [UIColor redColor];
    [newTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    return newTableView;
}


- (CGRect)dropDowTableViewFrameForTextField:(DropDownTextField *)textField
{
    CGRect frame = CGRectZero;
    frame = textField.frame;
    frame.origin.y += textField.frame.size.height;
    frame.origin.x += textField.dropDownTableOriginOffset.width;
    frame.origin.y += textField.dropDownTableOriginOffset.height;
    frame = CGRectInset(frame, 1, 0);
    
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height +100);
    
    return frame;
}


#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSInteger numberOfRows = [self.autoCompleteSuggestions count];
//    [self expandAutoCompleteTableViewForNumberOfRows:numberOfRows];
    
    NSArray *arr =   [self.dropDownDataSource dropDownTextFieldDataSourceTextField:self];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *cellIdentifier = DropDownTextFieldCellIdentifier;
    
    if(!self.reuseIdentifier){
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [self autoCompleteTableViewCellWithReuseIdentifier:cellIdentifier];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier];
    }
    NSAssert(cell, @"Unable to create cell for autocomplete table");
    
   
    id <DropDownTextFieldShowCellTextLabel>  dropDownData = (id <DropDownTextFieldShowCellTextLabel>)[self.dropDownDataSource dropDownTextFieldDataSourceTextField:self][indexPath.row];
    
      NSString *suggestedString =  [(id <DropDownTextFieldShowCellTextLabel>)dropDownData getShowCellForTextLabel];
    
    if ([dropDownData respondsToSelector:@selector(getShowCellForTextLabel)]) {
    
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",suggestedString];
    

    return cell;
}

- (UITableViewCell *)autoCompleteTableViewCellWithReuseIdentifier:(NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:identifier];
//    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:self.textColor];
    [cell.textLabel setFont:self.font];
    return cell;
}

+ (NSString *) accessibilityLabelForIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:self.dropDownTableCellBackgroundColor];
}


#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dropDowRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *dropDowString = selectedCell.textLabel.text;
    self.text = dropDowString;
    
    id <DropDownTextFieldShowCellTextLabel>  dropDownData = (id <DropDownTextFieldShowCellTextLabel>)[self.dropDownDataSource dropDownTextFieldDataSourceTextField:self][indexPath.row];
    

    if([self.dropDownDelegate respondsToSelector:
        @selector(dropDownTextField:didSelectedWithData:forRowAtIndexPath:)]){
        
        [self.dropDownDelegate dropDownTextField:self didSelectedWithData:dropDownData forRowAtIndexPath:indexPath];
        
    }
    
    //TODO:需要隐藏tableview
    [self hideDropDownTableView];
    
}





@end
