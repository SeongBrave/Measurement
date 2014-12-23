//
//  TableViewBindingHelper.h
//  FoodDelivery
//
//  Created by DTSoft on 14-10-14.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

/**
 *  TableView代理实现mvvm的帮助类
 */

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SignalForCell.h"

@interface TableViewBindingHelper : NSObject


// forwards the UITableViewDelegate methods
@property (weak, nonatomic) id<UITableViewDelegate> delegate;
@property(nonatomic , assign)id<SignalForCell> singalDelegate;


@property(nonatomic , strong)RACSignal *m_addSignal;

+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)selection
                             tempClassCell:(Class)cellClass
                           reuseIdentifier:(NSString *)reuseIdentifier;

- (instancetype) initWithTableView:(UITableView *)tableView
                      sourceSignal:(RACSignal *)source
                  selectionCommand:(RACCommand *)selection
                     tempClassCell:(Class)cellClass
                   reuseIdentifier:(NSString *)reuseIdentifier;

- (instancetype) initWithTableView:(UITableView *)tableView
                      sourceSignal:(RACSignal *)source
                  selectionCommand:(RACCommand *)selection
                      templateCell:(UINib *)templateCellNib;

+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)selection
                              templateCell:(UINib *)templateCellNib;


- (instancetype) initWithTableView:(UITableView *)tableView
                      sourceSignal:(RACSignal *)source
                  selectionCommand:(RACCommand *)selection
                 registerClassCell:(Class)cellClass
                   reuseIdentifier:(NSString *)reuseIdentifier;


+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)selection
                              registerClassCell:(Class)cellClass
                           reuseIdentifier:(NSString *)reuseIdentifier;

@end
