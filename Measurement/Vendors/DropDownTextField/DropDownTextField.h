//
//  DropDownTextField.h
//  scrollView
//
//  Created by DTSoft on 15/1/6.
//  Copyright (c) 2015年 山西金仕达软件有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoTextField.h"

@class DropDownTextField;

@protocol DropDownTextFieldShowCellTextLabel <NSObject>

@required

/**
 *  用于显示tableviewcell的数据，光显示一个text
 *
 *  @return textlabel要显示的数据
 */
- (NSString *)getShowCellForTextLabel;

@end




@protocol  DropDownTextFieldDelegate<NSObject>

-(void)dropDownTextField:(DropDownTextField *)textField didSelectedWithData:(id<DropDownTextFieldShowCellTextLabel>) data forRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@protocol DropDownTextFieldDataSource <NSObject>

-(NSArray *)dropDownTextFieldDataSourceTextField:(DropDownTextField *)textField;

@end





@interface DropDownTextField : DemoTextField<UITableViewDataSource, UITableViewDelegate>

@property (strong, readonly) UITableView *dropDownTableView;

@property(nonatomic , assign)id<DropDownTextFieldDelegate> dropDownDelegate;

@property(nonatomic , assign)id<DropDownTextFieldDataSource> dropDownDataSource;


/**
 *  对应的编码
 */
@property(nonatomic ,strong)NSString *m_bm;

@property (assign) CGFloat dropDownFontSize;
@property (strong) NSString *dropDownFontName;


@property (assign) CGFloat dropDowRowHeight;
@property (nonatomic, assign) CGRect dropDowTableFrame;
@property (assign) CGSize dropDownTableOriginOffset;
@property (assign) CGFloat dropDownTableCornerRadius; //only applies for drop down style autocomplete tables.

@property (nonatomic, assign) UIEdgeInsets dropDownContentInsets;
@property (nonatomic, assign) UIEdgeInsets dropDownScrollIndicatorInsets;
@property (nonatomic, strong) UIColor *dropDownTableBorderColor;
@property (nonatomic, assign) CGFloat dropDownTableBorderWidth;
@property (nonatomic, strong) UIColor *dropDownTableBackgroundColor;
@property (strong) UIColor *dropDownTableCellBackgroundColor;
@property (strong) UIColor *dropDownTableCellTextColor;

- (void)registerDropDownCellNib:(UINib *)nib forCellReuseIdentifier:(NSString *)reuseIdentifier;

- (void)registerDropDownCellClass:(Class)cellClass forCellReuseIdentifier:(NSString *)reuseIdentifier;

- (void)reloadData;

@end
