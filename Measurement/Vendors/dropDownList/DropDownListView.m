//
//  DropDownListView.m
//  DropDownDemo
//
//  Created by 童明城 on 14-5-28.
//  Copyright (c) 2014年 童明城. All rights reserved.
//

#import "DropDownListView.h"
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))

@implementation DropDownListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
    
    }
    return self;
}


-(void)InitUI
{
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;

    
    currentExtendSection = -1;


    
    UIButton *sectionBtn = [[UIButton alloc] init];
    sectionBtn.tag = SECTION_BTN_TAG_BEGIN;
    [sectionBtn addTarget:self action:@selector(sectionBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    NSString *sectionBtnTitle = @"";
    if ([self.dropDownDataSource respondsToSelector:@selector(titleInindex:)]) {
        sectionBtnTitle = [self.dropDownDataSource titleInindex:[self.dropDownDataSource defaultShowInindex]];
    }
    
    [sectionBtn  setTitle:sectionBtnTitle forState:UIControlStateNormal];
    [sectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sectionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self addSubview:sectionBtn];
    
    [sectionBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        
        
        make.leading.equalTo(self.mas_leading); //设置中线视图
        make.center.equalTo(self);
        make.top.equalTo(self.mas_top).offset(1);
        
    }];
    
    
    UIImageView *sectionBtnIv = [[UIImageView alloc]init];
    [sectionBtnIv setImage:[UIImage imageNamed:@"down_dark.png"]];
    [sectionBtnIv setContentMode:UIViewContentModeScaleToFill];
    sectionBtnIv.tag = SECTION_IV_TAG_BEGIN;
    
    [self addSubview: sectionBtnIv];
    
    
    [sectionBtnIv mas_updateConstraints:^(MASConstraintMaker *make) {
        
        
        make.trailing.equalTo(self.mas_trailing).offset(-8); //设置中线视图
        
        make.width.equalTo(@12);
        make.height.equalTo(@12);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    
    
    
}
-(void)sectionBtnTouch:(UIButton *)btn
{
    NSInteger section = btn.tag - SECTION_BTN_TAG_BEGIN;
    
 
    UIImageView *currentIV= (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN +currentExtendSection)];
    
    
    
    if (currentExtendSection == section) {
        [self hideExtendedChooseView];
    }else{
        currentExtendSection = section;
        currentIV = (UIImageView *)[self viewWithTag:SECTION_IV_TAG_BEGIN + currentExtendSection];
        [UIView animateWithDuration:0.3 animations:^{
            currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
        }];
        
        [self showChooseListViewInSection:currentExtendSection choosedIndex:[self.dropDownDataSource defaultShowInindex]];
    }

}

- (void)setTitle:(NSString *)title inSection:(NSInteger) section
{
    UIButton *btn = (id)[self viewWithTag:SECTION_BTN_TAG_BEGIN +section];
    [btn setTitle:title forState:UIControlStateNormal];
}

- (BOOL)isShow
{
    if (currentExtendSection == -1) {
        return NO;
    }
    return YES;
}
-  (void)hideExtendedChooseView
{
 
    
    UIImageView *currentIV= (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN +currentExtendSection)];
    
    [UIView animateWithDuration:0.3 animations:^{
        currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
    }];
    
    [ self.mTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        
        make.height.equalTo(@0);
        
    }];
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [self layoutIfNeeded];
        currentExtendSection = -1;
        [self.mTableView removeFromSuperview];
        
    }completion:NULL];
    
}

-(void)showChooseListViewInSection:(NSInteger)section choosedIndex:(NSInteger)index
{
    if (!self.mTableView) {

        
        self.mTableView = [[UITableView alloc] init];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        
    }

    [self.superview addSubview:self.mTableView];
    
    //    隐藏多余行的分割线
    self.mTableView.tableFooterView = [[UIView alloc] init];
    
    self.mTableView.layer.borderWidth = 2.0;
    self.mTableView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    [ self.mTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        
        make.trailing.equalTo(self.mas_trailing).offset(0); //设置中线视图
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.mas_bottom).offset(-1);
        make.height.equalTo(@120);
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [self layoutIfNeeded];
    }completion:NULL];
    
    [self.mTableView reloadData];
}

#pragma mark -- UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dropDownDelegate respondsToSelector:@selector(chooseAtindex:)])
    {
        NSString *chooseCellTitle = [self.dropDownDataSource titleInindex:indexPath.row];
        
        UIButton *currentSectionBtn = (UIButton *)[self viewWithTag:SECTION_BTN_TAG_BEGIN + currentExtendSection];
        [currentSectionBtn setTitle:chooseCellTitle forState:UIControlStateNormal];
        
        [self.dropDownDelegate chooseAtindex:indexPath.row];
        
          [self hideExtendedChooseView];
        
    }
  
}

#pragma mark -- UITableView DataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dropDownDataSource numberOfindex];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = [self.dropDownDataSource titleInindex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    return cell;
}



@end
