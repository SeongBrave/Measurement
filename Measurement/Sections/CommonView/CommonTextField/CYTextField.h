//
//  CYTextField.h
//  BedsNursingApp
//
//  Created by fanjinhao on 14-6-3.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CYTextField;

@protocol CYTextFieldDelegate <NSObject>

-(void)dateChangedWithDate:(NSDate *) date;

@end

@protocol CYTextFieldAutoFillDataSource <NSObject>

@optional

- (NSUInteger)minimumLengthForAutoFillQueryForTextField:(CYTextField *) _textField;


- (UITableViewCell *)textField:(CYTextField *) _textField tableView:(UITableView *) _tableView cellForAutoFillString:(NSString *) _string atIndexPath:(NSIndexPath *) _indexPath;


- (BOOL)textField:(CYTextField *) _textField canRemoveAutoFillString:(NSString *) _string atIndexPath:(NSIndexPath *)_indexPath;


- (void)textField:(CYTextField *) _textField removeAutoFillString:(NSString *) _string atIndexPath:(NSIndexPath *) _indexPath;

@required

- (NSArray *)textField:(CYTextField *) _textField autoFillStringsForString:(NSString *) _string;

@end

typedef enum
{
    CYOtherTextField = 0,
    CYAvatarTextField,
    
    CYNormalPickerTextField,        //表示正常的单选择
    
    CYbodyTempTextField,             //表示输入体温
    
    CYbodyTempTypeTextField,         //表示输入体温类型
    
    CYBlutDruckTextField,            //表示输入类型为血压
    
    CYDateTextField,                //表示输入类型为时间
    
    
    CYbodyWeightTextField,          //表示体重类型
    
    
    CYEmailTextField,
    
    CYPasswordTextField,
    CYUserNameTextField,
    CYGenderTextField,
    CYConstellationTextField
    
} CYTextFieldType;


#import "CommonTextField.h"

@interface CYTextField : CommonTextField


@property(nonatomic , assign) id<CYTextFieldDelegate> cyDelegate;

@property (readonly, nonatomic) id<UITextFieldDelegate> customDelegate;

@property (assign, nonatomic) BOOL inputAccessoryViewHidden;

@property (weak, nonatomic) UIResponder *previousField, *nextField;

@property (readonly, nonatomic) UIBarButtonItem *previousNextBarButtonItem;

@property (assign, nonatomic) BOOL previousBarButtonEnabled, nextBarButtonEnabled;

@property (assign, nonatomic) id<CYTextFieldAutoFillDataSource> autoFillDataSource;

@property (readonly, nonatomic) UIBarButtonItem *autoFillBarButtonItem;

@property (assign, nonatomic) BOOL autoFillBarButtonHidden;

@property (assign, nonatomic) BOOL autoFillBarButtonEnabled;

@property (assign, nonatomic) BOOL textFieldShouldReturnAfterAutoFill;

@property (assign, nonatomic) CGFloat presentAutoFillAnimationDuration;

@property (assign, nonatomic) CGFloat dismissAutoFillAnimationDuration;

@property (readonly, nonatomic) UIBarButtonItem *doneBarButtonItem;

@property (assign, nonatomic) BOOL doneBarButtonHidden;

@property (assign, nonatomic) BOOL doneBarButtonEnabled;

@property (assign, nonatomic) NSUInteger maximumLength;

@property (assign, nonatomic) BOOL allowSwipeToDismissKeyboard;

//
@property (nonatomic) BOOL  m_required; // 默认为no

@property (nonatomic, assign) CYTextFieldType m_textFieldType;

@property (nonatomic, assign) NSInteger maxTextLength; // default is  140

@property (nonatomic, assign) CGPoint rectInsetPoint; // default is (10, 5)


//CustomTextField

@property(nonatomic , strong) NSMutableDictionary *m_pVDataSourceDict;

@property(nonatomic , strong)NSString *strValue;  //用于保存当前textfield的值对应的key，方便更新数据



/**
 *  验证textfield的数据
 *
 *  @return 返回yes则符合
 */
- (BOOL)validate;

/**
 *  更具选择的时间返回时间点
 *
 *  @param date 传入选择的时间
 *
 *  @return 时间点
 */
+ (NSString *)getPointInTime:(NSDate *)date;

@end
