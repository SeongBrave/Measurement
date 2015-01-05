//
//  AutoCompleteTextField.h
//  uitextFieldTabV
//
//  Created by DTSoft on 15/1/5.
//  Copyright (c) 2015年 山西金仕达软件有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoCompleteTextFieldDataSource.h"
#import "AutoCompleteTextFieldDelegate.h"
#import "UITextField+RACSignalSupport.h"

@protocol AutoCompleteSortOperationDelegate <NSObject>
- (void)autoCompleteTermsDidSort:(NSArray *)completions;
@end

@interface AutoCompleteTextField : UITextField<UITableViewDataSource, UITableViewDelegate, AutoCompleteSortOperationDelegate>


@property (strong, readonly) UITableView *autoCompleteTableView;

// all delegates and datasources should be weak referenced
@property (weak) IBOutlet id <AutoCompleteTextFieldDataSource> autoCompleteDataSource;
@property (weak) IBOutlet id <AutoCompleteTextFieldDelegate> autoCompleteDelegate;

@property (assign) NSTimeInterval autoCompleteFetchRequestDelay; //default is 0.1, if you fetch from a web service you may want this higher to prevent multiple calls happening very quickly.
@property (assign) BOOL sortAutoCompleteSuggestionsByClosestMatch;
@property (assign) BOOL applyBoldEffectToAutoCompleteSuggestions;
@property (assign) BOOL reverseAutoCompleteSuggestionsBoldEffect;
@property (assign) BOOL showTextFieldDropShadowWhenAutoCompleteTableIsOpen;
@property (assign) BOOL showAutoCompleteTableWhenEditingBegins; //only applies for drop down style autocomplete tables.
@property (assign) BOOL disableAutoCompleteTableUserInteractionWhileFetching;
@property (assign) BOOL autoCompleteTableAppearsAsKeyboardAccessory; //if set to TRUE, the autocomplete table will appear as a keyboard input accessory view rather than a drop down.
@property (assign) BOOL shouldResignFirstResponderFromKeyboardAfterSelectionOfAutoCompleteRows; // default is TRUE


@property (assign) BOOL autoCompleteTableViewHidden;

@property (assign) CGFloat autoCompleteFontSize;
@property (strong) NSString *autoCompleteBoldFontName;
@property (strong) NSString *autoCompleteRegularFontName;

@property (assign) NSInteger maximumNumberOfAutoCompleteRows;
@property (assign) CGFloat partOfAutoCompleteRowHeightToCut; // this number multiplied by autoCompleteRowHeight will be subtracted from total tableView height.
@property (assign) CGFloat autoCompleteRowHeight;
@property (nonatomic, assign) CGRect autoCompleteTableFrame;
@property (assign) CGSize autoCompleteTableOriginOffset;
@property (assign) CGFloat autoCompleteTableCornerRadius; //only applies for drop down style autocomplete tables.
@property (nonatomic, assign) UIEdgeInsets autoCompleteContentInsets;
@property (nonatomic, assign) UIEdgeInsets autoCompleteScrollIndicatorInsets;
@property (nonatomic, strong) UIColor *autoCompleteTableBorderColor;
@property (nonatomic, assign) CGFloat autoCompleteTableBorderWidth;
@property (nonatomic, strong) UIColor *autoCompleteTableBackgroundColor;
@property (strong) UIColor *autoCompleteTableCellBackgroundColor;
@property (strong) UIColor *autoCompleteTableCellTextColor;


- (void)registerAutoCompleteCellNib:(UINib *)nib forCellReuseIdentifier:(NSString *)reuseIdentifier;

- (void)registerAutoCompleteCellClass:(Class)cellClass forCellReuseIdentifier:(NSString *)reuseIdentifier;

- (void)reloadData; //it will ask DataSource for data again


@end
