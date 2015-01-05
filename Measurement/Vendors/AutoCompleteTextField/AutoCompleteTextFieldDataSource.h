//
//  AutoCompleteTextFieldDataSource.h
//  uitextFieldTabV
//
//  Created by DTSoft on 15/1/5.
//  Copyright (c) 2015年 山西金仕达软件有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AutoCompleteTextField;
@protocol AutoCompleteTextFieldDataSource <NSObject>


- (void)autoCompleteTextField:(AutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void(^)(NSArray *suggestions))handler;



/*
 Like the above, this method should return an NSArray of strings or objects implementing the MLPAutoCompletionObject protocol
 that could be used as possible completions for the given string in textField.
 This method will be called asynchronously, so an immediate return is not necessary.
 */

-(NSArray *)autoCompleteDataSourceTextField:(AutoCompleteTextField *)textField;

- (NSArray *)autoCompleteTextField:(AutoCompleteTextField *)textField
      possibleCompletionsForString:(NSString *)string;

@end
