//
//  DropDownChooseProtocol.h
//  DropDownDemo
//
//  Created by 童明城 on 14-5-28.
//  Copyright (c) 2014年 童明城. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DropDownChooseDelegate <NSObject>

@optional

-(void) chooseAtindex:(NSInteger)index;
@end

@protocol DropDownChooseDataSource <NSObject>
-(NSInteger)numberOfindex;
-(NSString *)titleInindex:(NSInteger) index;
-(NSInteger)defaultShowInindex;



@end



