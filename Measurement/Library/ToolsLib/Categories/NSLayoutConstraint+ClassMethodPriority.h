//
//  NSLayoutConstraint+ClassMethodPriority.h
//  MClinicalNursing
//
//  Created by 成勇 on 14-4-13.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (ClassMethodPriority)


//可以设定优先级
+ (id)constraintWithItem:(id)view1
			   attribute:(NSLayoutAttribute)attr1
			   relatedBy:(NSLayoutRelation)relation
				  toItem:(id)view2
			   attribute:(NSLayoutAttribute)attr2
			  multiplier:(CGFloat)multiplier
				constant:(CGFloat)c
				priority:(UILayoutPriority)priority;


@end
