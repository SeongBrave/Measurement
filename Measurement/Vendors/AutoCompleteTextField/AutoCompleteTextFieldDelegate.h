//
//  AutoCompleteTextFieldDelegate.h
//  uitextFieldTabV
//
//  Created by DTSoft on 15/1/5.
//  Copyright (c) 2015年 山西金仕达软件有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AutoCompletionObject.h"

@class AutoCompleteTextField;

@protocol AutoCompleteTextFieldDelegate <NSObject>


- (BOOL)autoCompleteTextField:(AutoCompleteTextField *)textField
shouldStyleAutoCompleteTableView:(UITableView *)autoCompleteTableView
               forBorderStyle:(UITextBorderStyle)borderStyle;

/*IndexPath corresponds to the order of strings within the autocomplete table,
 not the original data source.*/
- (BOOL)autoCompleteTextField:(AutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<AutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;


/*IndexPath corresponds to the order of strings within the autocomplete table,
 not the original data source.
 autoCompleteObject may be nil if the selectedString had no object associated with it.
 */
- (void)autoCompleteTextField:(AutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<AutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)autoCompleteTextField:(AutoCompleteTextField *)textField
willShowAutoCompleteTableView:(UITableView *)autoCompleteTableView;

- (void)autoCompleteTextField:(AutoCompleteTextField *)textField
 didChangeNumberOfSuggestions:(NSInteger)numberOfSuggestions;

@end
