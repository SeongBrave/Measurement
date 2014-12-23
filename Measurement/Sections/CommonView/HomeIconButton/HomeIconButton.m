//
//  HomeIconButton.m
//  ThirdTown
//
//  Created by DTSoft on 14/12/9.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "HomeIconButton.h"

@implementation HomeIconButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.initialized=NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.initialized) {
        return;
    }
    //取消IB中的title
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateHighlighted];
    
    
       //显示自己添加的的title
    UILabel * l=[[UILabel alloc]initWithFrame:CGRectMake(0, 56, self.bounds.size.width ,22)];
    l.text=[self.dataSource setIconTitle];
    l.textAlignment=NSTextAlignmentCenter;
    l.font = [UIFont fontWithName:@"Arial" size:12];
    l.textColor=[UIColor colorWithRed:150./255 green:150./255 blue:150./255 alpha:150./255];
    [self addSubview:l];
    //添加图片
    UIImage * img=[self.dataSource setIcon];
    [self setImage:img forState:UIControlStateNormal];
    [self setImage:img forState:UIControlStateHighlighted];
    //设置背景图片
    UIImage * bgimg=[UIImage imageNamed:@"app_item_pressed_bg"];
    [self setBackgroundImage:bgimg forState:UIControlStateHighlighted];
    
    
    self.m_info = [self.dataSource setBtnInfo];
    
//    NSMutableDictionary * dict = [self.dataSource setBtnInfo];

    
    
    //设置insets
    self.contentEdgeInsets=UIEdgeInsetsMake(-11, 0, 0, 0);
    //响应事件
    [self addTarget:self action:@selector(pressed) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
    self.initialized=YES;
}
-(void)pressed{
    self.backgroundColor=[UIColor colorWithRed:235./255 green:235./255 blue:235./255 alpha:1];
}
-(void)touchUp{
    self.backgroundColor=[UIColor whiteColor];
    
    if ([self.delegate respondsToSelector:@selector(didSelectWithHomeIconButton:)]) {
        [self.delegate didSelectWithHomeIconButton:self];
    }
}
@end
