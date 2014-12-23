//
//  HomeIconButton.h
//  ThirdTown
//
//  Created by DTSoft on 14/12/9.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@class HomeIconButton;

@protocol HomeIconButtonDataSource <NSObject>
-(NSString *)setIconTitle;
-(UIImage * )setIcon;
-(NSMutableDictionary *)setBtnInfo;
@end

@protocol HomeIconButtonDelegate <NSObject>

-(void)didSelectWithHomeIconButton:(HomeIconButton *) iconBtn;

@end

@interface HomeIconButton : UIButton

@property(nonatomic , strong) NSMutableDictionary *m_info; //保存一些buton中需要保存的信息
@property (nonatomic,strong) NSString * titleBelowIcon;
@property (nonatomic, assign)IBOutlet id <HomeIconButtonDataSource> dataSource;
@property (nonatomic, assign)IBOutlet id <HomeIconButtonDelegate> delegate;

@property (nonatomic,assign) BOOL initialized;

@end
