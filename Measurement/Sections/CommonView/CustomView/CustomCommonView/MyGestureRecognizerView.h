//
//  MyGestureRecognizerView.h
//  MClinicalNursing
//
//  Created by 成勇 on 14-4-10.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol MyGestureRecognizerDelegate <NSObject>

- (void)leftswipGesture:(UIGestureRecognizer*)gesture andWithGestureView:(UIView*) _gestureView;
- (void)rightswipGesture:(UIGestureRecognizer*)gesture andWithGestureView:(UIView*) _gestureView;
- (void)swipGesture:(UISwipeGestureRecognizer *)gesture andWithGestureView:(UIView*) _gestureView;
- (void)panGesture:(UIPanGestureRecognizer *)gesture andWithGestureView:(UIView*) _gestureView;
- (void)scaleGesture:(UIPinchGestureRecognizer*)gesture andWithGestureView:(UIView*) _gestureView;
- (void)tapGesture:(UITapGestureRecognizer*)gesture andWithGestureView:(UIView*) _gestureView;
- (void)longPressGesture:(UILongPressGestureRecognizer*)gesture andWithGestureView:(UIView*) _gestureView;

@end

@interface MyGestureRecognizerView : UIView<UIGestureRecognizerDelegate>

@property(nonatomic , assign)id<MyGestureRecognizerDelegate> gestureDelegate;


-(id)initWithTheDelegate:(id<MyGestureRecognizerDelegate>) _MyDelegate;

@end
