//
//  CYTextFieldAutoFillInputView.h
//  BedsNursingApp
//
//  Created by fanjinhao on 14-6-3.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTextField;

@interface CYTextFieldAutoFillInputView : UIView

- (void)presentForTextField:(CYTextField *) textField;
- (void)dismiss;

@end
