//
//  UtilsMacro.h
//  MClinicalNursing
//
//  Created by 成勇 on 14-4-4.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

//放的是一些方便使用的宏定义
#ifndef MClinicalNursing_UtilsMacro_h
#define MClinicalNursing_UtilsMacro_h

#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:((float)(r))/255.0 green:((float)(g))/255.0 blue:((float)(b))/255.0 alpha:1.0]

#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)?YES:NO
#define ISFourSquare ([UIScreen mainScreen].bounds.size.height<568? NO:YES)


//UI

// View 坐标(x,y)和宽高(width,height)
#define SetX(v)               (v).frame.origin.x
#define SetY(v)               (v).frame.origin.y
#define SetWidth(v)           (v).frame.size.width
#define SetHeight(v)          (v).frame.size.height

#define GetX(v)            CGRectGetMinX((v).frame) // 获得控件屏幕的x坐标
#define GetY(v)            CGRectGetMinY((v).frame) // 获得控件屏幕的Y坐标
#define GetWidth(v)           (v).frame.size.width
#define GetHeight(v)          (v).frame.size.height

#define GetMidX(v)            CGRectGetMidX((v).frame) //横坐标加上到控件中点坐标
#define GetMidY(v)            CGRectGetMidY((v).frame) //纵坐标加上到控件中点坐标

#define GetMaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define GetMaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度



#if __IPHONE_6_0 // iOS6 and later

#   define kTextAlignmentCenter    NSTextAlignmentCenter
#   define kTextAlignmentLeft      NSTextAlignmentLeft
#   define kTextAlignmentRight     NSTextAlignmentRight

#   define kTextLineBreakByWordWrapping      NSLineBreakByWordWrapping
#   define kTextLineBreakByCharWrapping      NSLineBreakByCharWrapping
#   define kTextLineBreakByClipping          NSLineBreakByClipping
#   define kTextLineBreakByTruncatingHead    NSLineBreakByTruncatingHead
#   define kTextLineBreakByTruncatingTail    NSLineBreakByTruncatingTail
#   define kTextLineBreakByTruncatingMiddle  NSLineBreakByTruncatingMiddle

#else // older versions

#   define kTextAlignmentCenter    UITextAlignmentCenter
#   define kTextAlignmentLeft      UITextAlignmentLeft
#   define kTextAlignmentRight     UITextAlignmentRight

#   define kTextLineBreakByWordWrapping       UILineBreakModeWordWrap
#   define kTextLineBreakByCharWrapping       UILineBreakModeCharacterWrap
#   define kTextLineBreakByClipping           UILineBreakModeClip
#   define kTextLineBreakByTruncatingHead     UILineBreakModeHeadTruncation
#   define kTextLineBreakByTruncatingTail     UILineBreakModeTailTruncation
#   define kTextLineBreakByTruncatingMiddle   UILineBreakModeMiddleTruncation

#endif
#define StatusBarStyle UIStatusBarStyleLightContent


//定义适配ios7 或四寸屏版本问题
#define StateBarHeight ((IS_IOS_7)?20:0)

#define NavBarHeight ((IS_IOS_7)?65:0)

#define BottomHeight ((IS_IOS_7)?49:0)

#define ScreenHeight ((IS_IOS_7)?([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.height - 20))

#define ConentViewWidth  [UIScreen mainScreen].bounds.size.width

#define ConentViewHeight ((IS_IOS_7)?([UIScreen mainScreen].bounds.size.height - NavBarHeight):([UIScreen mainScreen].bounds.size.height - NavBarHeight -20))

#define ConentViewFrame CGRectMake(0,NavBarHeight,ConentViewWidth,ConentViewHeight-BottomHeight)

#define MaskViewDefaultFrame CGRectMake(0,NavBarHeight-1,ConentViewWidth,ConentViewHeight)

#define MaskViewFullFrame CGRectMake(0,0,ConentViewWidth,[UIScreen mainScreen].bounds.size.height-20)


#endif
