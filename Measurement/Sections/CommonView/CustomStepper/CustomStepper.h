//
//  CustomStepper.h
//  ChildViewTest
//
//  Created by Icy on 14/10/21.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>
#import "StepperViewModel.h"

@interface CustomStepper : UIView


@property(nonatomic ,strong)UILabel *m_showLabel;
@property(nonatomic ,strong)UIButton *m_addBtn;
@property(nonatomic ,strong)UIButton *m_delBtn;

@property(nonatomic ,strong)RACSignal *m_Signal;


@property(nonatomic ,assign)int m_Count;


-(id)initCustomStepperWithCount:(int) count;

-(id)initCustomStepperWithCell:(UITableViewCell *)tableViewCell;
-(id)initCustomStepperWithCount:(int) count andWithCell:(UITableViewCell *)tableViewCell;
-(id)initCustomStepperWithCount:(int) count andWithCell:(UITableViewCell *)tableViewCell andPrice:(int) price;
@end
