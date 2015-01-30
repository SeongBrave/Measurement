//
//  DatePickerViewController.h
//  Measurement
//
//  Created by DTSoft on 14/12/30.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "BaseViewController.h"

@class DatePickerViewController;

@protocol DatePickerDelegate <NSObject>

-(void)DatePickerVC:(DatePickerViewController*)datePickerVC DidseletedDate:(NSDate*) date;


@end

@interface DatePickerViewController : BaseViewController

@property(nonatomic , strong)CustomButton *m_clickBtn;

/**
 *  设置datepicker的类型
 */
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (weak, nonatomic) IBOutlet UIDatePicker *m_datePicker;

@property(nonatomic , assign)id<DatePickerDelegate> dateDelegate;


/**
 *  用于保存初始化datepicker 的数据
 */
@property(nonatomic , strong)NSDate *m_date;



@end
