//
//  CustomStepper.m
//  ChildViewTest
//
//  Created by Icy on 14/10/21.
//  Copyright (c) 2014年 ISoft. All rights reserved.
//

#import "CustomStepper.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <Masonry/Masonry.h>



@interface CustomStepper()

@property(nonatomic , strong)NSString *m_showCount;
@end
@implementation CustomStepper


-(id)initCustomStepperWithCount:(int) count
{
    self = [super init];
    if (self) {
        
        self.m_Count = count;
        
        [self layoutCustomView];
        @weakify(self)
        RAC(self.m_showLabel,text) = [[RACObserve(self,m_Count) filter:^BOOL(NSNumber *number){
            return ([number intValue]) >0;
            
        } ]map:^id(NSNumber *number){
            
            return [NSString stringWithFormat:@"%@",number];
            
        }];
        
        RACSignal *signalAdd = [[self.m_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(id next){
            
            @strongify(self)
            return @(self.m_Count);
            
        }]
        ;
        
        RACSignal *signalDel =[[[self.m_delBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
                                
                                map:^id(id next){
                                    
                                    @strongify(self)
                                    return @(self.m_Count);
                                    
                                }]
                               filter:^BOOL(NSNumber *number){
                                   
                                   return ([number intValue]) >=0;
                                   
                               }] ;
        
        
        
        [signalAdd subscribeNext:^(id sender){
            @strongify(self)
            self.m_Count ++;
            self.m_delBtn.hidden = NO;
            self.m_showLabel.hidden = NO;
        }];
        
        
        [signalDel subscribeNext:^(id sender){
            @strongify(self)
            self.m_delBtn.hidden = NO;
            self.m_showLabel.hidden = NO;
            if (self.m_Count != 0) {
                --self.m_Count;
            }
            
            
        }];
        
        
//        
//        self.m_AddSignal = signalAdd;
//        
//        self.m_DelSignal = signalDel;
        
        
    }
    return self;
}
-(id)initCustomStepperWithCell:(UITableViewCell *)tableViewCell
{
    self = [super init];
    if (self) {
        

        [self layoutCustomView];
        
        @weakify(self)
        
        
        RAC(self.m_showLabel,text) = [[RACObserve(self,m_Count) filter:^BOOL(NSNumber *number){
            return ([number intValue]) >0;
            
        } ]map:^id(NSNumber *number){
            
            return [NSString stringWithFormat:@"%@",number];
            
        }];
        
        RACSignal *signalAdd = [[[self.m_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:tableViewCell.rac_prepareForReuseSignal] map:^id(id next){
            
            @strongify(self)
            return @(self.m_Count);
            
        }]
        ;
        RACSignal *signalDel =[[[[self.m_delBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
                                 takeUntil:tableViewCell.rac_prepareForReuseSignal]
                                map:^id(id next){
                                    @strongify(self)
                                    return @(self.m_Count);
                                }]
                               filter:^BOOL(NSNumber *number){
                                   
                                   return ([number intValue]) >=0;
                                   
                               }] ;
        
        
        
        [signalAdd subscribeNext:^(id sender){
            @strongify(self)
            self.m_Count ++;
            self.m_delBtn.hidden = NO;
            self.m_showLabel.hidden = NO;
        }];
        
        
        [signalDel subscribeNext:^(id sender){
            @strongify(self)
            self.m_delBtn.hidden = NO;
            self.m_showLabel.hidden = NO;
            if (self.m_Count != 0) {
                --self.m_Count;
            }
            
        }];
        
//        self.m_AddSignal = signalAdd;
//        
//        self.m_DelSignal = signalDel;
        
        
    }
    return self;
}
-(id)initCustomStepperWithCount:(int) count andWithCell:(UITableViewCell *)tableViewCell
{
    self = [super init];
    if (self) {
        
        self.m_Count = count;
        
        [self layoutCustomView];
        
        @weakify(self)
        
        
        RAC(self.m_showLabel,text) = [[RACObserve(self,m_Count) filter:^BOOL(NSNumber *number){
            return ([number intValue]) >0;
            
        } ]map:^id(NSNumber *number){
            
            return [NSString stringWithFormat:@"%@",number];
            
        }];
        
        RACSignal *signalAdd = [[[[self.m_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:tableViewCell.rac_prepareForReuseSignal]  doNext:^(id sender){
            @strongify(self)
            self.m_Count ++;
            self.m_delBtn.hidden = NO;
            self.m_showLabel.hidden = NO;
        }]map:^id(id next){
            
            debug_int(self.m_Count);
            @strongify(self)
            return @(self.m_Count);
            
        }]
        ;
        RACSignal *signalDel =[[[[[self.m_delBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
                                  takeUntil:tableViewCell.rac_prepareForReuseSignal]doNext:^(id sender){
            @strongify(self)
            self.m_delBtn.hidden = NO;
            self.m_showLabel.hidden = NO;
            if (self.m_Count != 0) {
                --self.m_Count;
            }
        } ]
                                 map:^id(id next){
                                     @strongify(self)
                                     return @(self.m_Count);
                                 }]
                               filter:^BOOL(NSNumber *number){
                                   
                                   return ([number intValue]) >=0;
                                   
                               }] ;
        
        
//        self.m_AddSignal = signalAdd;
//        
//        self.m_DelSignal = signalDel;
     
     
        
        
    }
    return self;
}


-(id)initCustomStepperWithCount:(int) count andWithCell:(UITableViewCell *)tableViewCell andPrice:(int) price
{
    self = [super init];
    if (self) {
        
        self.m_Count = count;
        
        [self layoutCustomView];
        
        @weakify(self)
        
        
        RAC(self.m_showLabel,text) = [[RACObserve(self,m_Count) filter:^BOOL(NSNumber *number){
            return ([number intValue]) >0;
            
        } ]map:^id(NSNumber *number){
            
            return [NSString stringWithFormat:@"%@",number];
            
        }];
        
        RACSignal *signalAdd = [[[[self.m_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:tableViewCell.rac_prepareForReuseSignal]  doNext:^(id sender){
            @strongify(self)
            self.m_Count ++;
            self.m_delBtn.hidden = NO;
            self.m_showLabel.hidden = NO;
        }]map:^id(id next){
            
            debug_int(self.m_Count);
            @strongify(self)
            return @(self.m_Count);
            
        }]
        ;
        RACSignal *signalDel =[[[[[self.m_delBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
                                  takeUntil:tableViewCell.rac_prepareForReuseSignal]doNext:^(id sender){
            @strongify(self)
            self.m_delBtn.hidden = NO;
            self.m_showLabel.hidden = NO;
          
        } ]
                                map:^id(id next){
                                    @strongify(self)
                                    return @(self.m_Count);
                                }]
                               filter:^BOOL(NSNumber *number){
                                   if (self.m_Count != 0) {
                                       --self.m_Count;
                                   }
                                   return ([number intValue]) >=0;
                                   
                               }] ;
        
        
  
        
        
        self.m_Signal = [RACSignal merge:@[[signalAdd map:^id(NSNumber* value){
            
            return @(price);
            
        }], [signalDel map:^id(NSNumber* value){
            
            return @(-price);
            
        }]]];
        
        
        
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self layoutCustomView];
    
    @weakify(self)
    RAC(self.m_showLabel,text) = [[RACObserve(self,m_Count) filter:^BOOL(NSNumber *number){
        return ([number intValue]) >0;
        
    } ]map:^id(NSNumber *number){
        
        return [NSString stringWithFormat:@"%@",number];
        
    }];
    
    RACSignal *signalAdd = [[self.m_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(id next){
        
        @strongify(self)
        return @(self.m_Count);
        
    }]
    ;
    
    RACSignal *signalDel =[[[self.m_delBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
                            
                            map:^id(id next){
                                
                                @strongify(self)
                                return @(self.m_Count);
                                
                            }]
                           filter:^BOOL(NSNumber *number){
                               
                               return ([number intValue]) >=0;
                               
                           }] ;
    
    
    
    [signalAdd subscribeNext:^(id sender){
        @strongify(self)
        self.m_Count ++;
        self.m_delBtn.hidden = NO;
        self.m_showLabel.hidden = NO;
    }];
    
    
    [signalDel subscribeNext:^(id sender){
        @strongify(self)
        self.m_delBtn.hidden = NO;
        self.m_showLabel.hidden = NO;
        if (self.m_Count != 0) {
            --self.m_Count;
        }
        
        
    }];
    
    
//    
//    self.m_AddSignal = signalAdd;
//    
//    self.m_DelSignal = signalDel;
    
}

-(void)layoutCustomView
{
    @weakify(self)
    self.m_delBtn = [[UIButton alloc]init];
    [self.m_delBtn setImage:[UIImage imageNamed:@"DelBtn"] forState:UIControlStateNormal];
    
    self.m_delBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_m_delBtn];
    
    self.m_showLabel = [[UILabel alloc]init];
    self.m_showLabel.textAlignment = NSTextAlignmentCenter;
    self.m_showLabel.text = @"";
    self.m_showLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_m_showLabel];
    
    self.m_addBtn = [[UIButton alloc]init];
    self.m_addBtn.backgroundColor = [UIColor clearColor];
    [self.m_addBtn setImage:[UIImage imageNamed:@"AddBtn"] forState:UIControlStateNormal];
    [self addSubview:_m_addBtn];
    
    
    [ self.m_showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self)
        make.left.equalTo(self.m_delBtn.mas_right).offset(0);
        
        make.right.equalTo(self.m_addBtn.mas_leading);
        
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [ self.m_delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        
        make.left.equalTo(@0);
        
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@35);
        
        
    }];
    
    [ self.m_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(@0);
        
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.m_delBtn.mas_width).offset(0);
        make.height.equalTo(self.m_delBtn.mas_height).offset(0);
        
    }];
    
    //监听m_Count 当m_Count为0时 设置控件为隐藏
    [[RACObserve(self,m_Count) filter:^BOOL(NSNumber *number){
        
        return ([number intValue] == 0);
        
    } ]subscribeNext:^(id value){
        
        
        self.m_delBtn.hidden = YES;
        self.m_showLabel.hidden = YES;
    }];
    
    //监听m_Count 当m_Count为大于0时 设置控件为显示
    [[RACObserve(self,m_Count) filter:^BOOL(NSNumber *number){
        
        return ([number intValue] >0);
        
    } ]subscribeNext:^(id value){
        
        
        self.m_delBtn.hidden = NO;
        self.m_showLabel.hidden = NO;
    }];
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        [self layoutCustomView];
        
        @weakify(self)
        
        [[self.m_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id sender){
            @strongify(self)
            self.m_Count ++;
            self.m_delBtn.hidden = NO;
            self.m_showLabel.hidden = NO;
        }];
        
        
        [[[[self.m_delBtn rac_signalForControlEvents:UIControlEventTouchUpInside]map:^id(id next){
            @strongify(self)
            return @(self.m_Count);
        }]filter:^BOOL(NSNumber *number){
            
            return ([number intValue]) ==1;
            
        } ]subscribeNext:^(id sender){
            @strongify(self)
            self.m_Count =0;
            self.m_delBtn.hidden = YES;
            self.m_showLabel.hidden = YES;
            
            
        }];
        
        
        [[[[self.m_delBtn rac_signalForControlEvents:UIControlEventTouchUpInside]map:^id(id next){
            @strongify(self)
            return @(self.m_Count);
        }]filter:^BOOL(NSNumber *number){
            
            return ([number intValue]) >0;
            
        } ]subscribeNext:^(id sender){
            @strongify(self)
            self.m_delBtn.hidden = NO;
            self.m_showLabel.hidden = NO;
            --self.m_Count;
            
        }];
        
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
