//
//  MyGestureRecognizerView.m
//  MClinicalNursing
//
//  Created by 成勇 on 14-4-10.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "MyGestureRecognizerView.h"

@implementation MyGestureRecognizerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
         [self addGestureRecognizersToPiece:self];
    }
    return self;
}

-(void)addGestureRecognizersToPiece:(UIView*) _piece
{
//    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]  initWithTarget:self action:@selector(scalePiece:)];
//    pinchGesture.delegate = self;
//    [_piece addGestureRecognizer:pinchGesture];
//    
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panPiece:)];
//    panGesture.maximumNumberOfTouches = 2;
//    panGesture.delegate = self;
//    [_piece addGestureRecognizer:panGesture];
    
    
    //定义向右滑动
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    
    [rightGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [_piece addGestureRecognizer:rightGesture];
    
    //定义向左滑动
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    [leftGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_piece addGestureRecognizer:leftGesture];
    
    
//    //定义向下滑动
//    UISwipeGestureRecognizer *downGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(downSwipe:)];
//    [downGesture setDirection:UISwipeGestureRecognizerDirectionDown];
//    [_piece addGestureRecognizer:downGesture];
//    
//    
//    //定义向上滑动
//    UISwipeGestureRecognizer *upGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upSwipe:)];
//    [upGesture setDirection:UISwipeGestureRecognizerDirectionUp];
//    [_piece addGestureRecognizer:upGesture];
}

- (void)rightSwipe:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer view].transform.a!=1) {
        return;
    }
    if ([self.gestureDelegate respondsToSelector:@selector(rightswipGesture: andWithGestureView:)]) {
        [self.gestureDelegate rightswipGesture:gestureRecognizer  andWithGestureView:self];
    }
}

- (void)leftSwipe:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer view].transform.a!=1) {
        return;
    }
    
    if ([self.gestureDelegate respondsToSelector:@selector(leftswipGesture:andWithGestureView:)]) {
        [self.gestureDelegate leftswipGesture:gestureRecognizer  andWithGestureView:self];
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // if the gesture recognizers's view isn't one of our pieces, don't allow simultaneous recognition
    if (gestureRecognizer.view != self)
        return NO;
    
    // if the gesture recognizers are on different views, don't allow simultaneous recognition
    if (gestureRecognizer.view != otherGestureRecognizer.view)
        return NO;
    
    // if either of the gesture recognizers is the long press, don't allow simultaneous recognition
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
        return NO;
    
    return YES;
}

-(id)initWithTheDelegate:(id<MyGestureRecognizerDelegate>) _MyDelegate
{
    self = [super init];
    if (self) {
        [self addGestureRecognizersToPiece:self];
        self.gestureDelegate = _MyDelegate;
    }
    
    return self;
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addGestureRecognizersToPiece:self];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
