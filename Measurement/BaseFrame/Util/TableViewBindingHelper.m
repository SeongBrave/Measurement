//
//  TableViewBindingHelper.m
//  FoodDelivery
//
//  Created by DTSoft on 14-10-14.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import "TableViewBindingHelper.h"
#import "ReactiveTViewProtocol.h"
#import <ReactiveCocoa/RACEXTScope.h>


@interface TableViewBindingHelper () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic , strong)UITableView *m_tableView;

@end

@implementation TableViewBindingHelper
{
    UITableView *_tableView;
    NSArray *_data;
    UITableViewCell *_templateCell;
    RACCommand *_selection;
    NSString *reuse_Identifier;
}


#pragma  mark - initialization

- (instancetype)initWithTableView:(UITableView *)tableView
                     sourceSignal:(RACSignal *)source
                 selectionCommand:(RACCommand *)selection
                     templateCell:(UINib *)templateCellNib {
    
    if (self = [super init]) {
        _tableView = tableView;
        _data = [NSArray array];
        _selection = selection;
        
        // each time the view model updates the array property, store the latest
        // value and reload the table view
        [source subscribeNext:^(id x) {
            self->_data = x;
            [self->_tableView reloadData];
        }];
        
        // create an instance of the template cell and register with the table view
        _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
        [_tableView registerNib:templateCellNib forCellReuseIdentifier:_templateCell.reuseIdentifier];
        
        // use the template cell to set the row height
        _tableView.rowHeight = _templateCell.bounds.size.height;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return self;
}

- (instancetype) initWithTableView:(UITableView *)tableView
                      sourceSignal:(RACSignal *)source
                  selectionCommand:(RACCommand *)selection
                     registerClassCell:(Class)cellClass
                   reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super init]) {
        _tableView = tableView;
        _data = [NSArray array];
        _selection = selection;
        
        // each time the view model updates the array property, store the latest
        // value and reload the table view
        [source subscribeNext:^(id x) {
            self->_data = x;
            [self->_tableView reloadData];
        }];
        
        
        
        self.m_addSignal = [RACSignal merge:@[]];
        
        
        // create an instance of the template cell and register with the table view
        
        
        
        [_tableView registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
        reuse_Identifier = reuseIdentifier;
        // use the template cell to set the row height
        //        _tableView.rowHeight = _templateCell.bounds.size.height;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return self;
    
}


- (instancetype) initWithTableView:(UITableView *)tableView
                      sourceSignal:(RACSignal *)source
                  selectionCommand:(RACCommand *)selection
                     tempClassCell:(Class)cellClass
                   reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super init]) {
        _tableView = tableView;
        _data = [NSArray array];
        _selection = selection;
        
        // each time the view model updates the array property, store the latest
        // value and reload the table view
        [source subscribeNext:^(id x) {
            self->_data = x;
            [self->_tableView reloadData];
        }];
    
     

        reuse_Identifier = reuseIdentifier;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return self;
    
}


+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)selection
                         registerClassCell:(Class)cellClass
                           reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[TableViewBindingHelper alloc] initWithTableView:tableView
                                                sourceSignal:source
                                            selectionCommand:selection
                                               registerClassCell:cellClass
                                             reuseIdentifier:reuseIdentifier];
}
+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)selection
                             tempClassCell:(Class)cellClass
                           reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[TableViewBindingHelper alloc] initWithTableView:tableView
                                                sourceSignal:source
                                            selectionCommand:selection
                                               tempClassCell:cellClass
                                             reuseIdentifier:reuseIdentifier];
}
+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                             sourceSignal:(RACSignal *)source
                         selectionCommand:(RACCommand *)selection
                             templateCell:(UINib *)templateCellNib{
    
    return [[TableViewBindingHelper alloc] initWithTableView:tableView
                                                  sourceSignal:source
                                              selectionCommand:selection
                                                  templateCell:templateCellNib];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    id<ReactiveTViewProtocol> cell = [tableView dequeueReusableCellWithIdentifier:reuse_Identifier forIndexPath:indexPath];
    
    [cell bindViewModel:_data[indexPath.row]];
    


     @weakify(self)
    [[cell getSignal] subscribeNext:^(id value){
        
        @strongify(self)
        if ([self.singalDelegate respondsToSelector:@selector(didSelectForSignal:)]) {
            [self.singalDelegate didSelectForSignal:value];
        }
        
    }];
    
    return (UITableViewCell *)cell;
}

#pragma mark = UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // execute the command
    [_selection execute:_data[indexPath.row]];
    
    // forward the delegate method
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    
}
#pragma mark = UITableViewDelegate forwarding

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        return self.delegate;
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end
