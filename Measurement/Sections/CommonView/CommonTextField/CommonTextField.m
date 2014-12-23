//
//  CommonTextField.m
//  BedsNursingApp
//
//  Created by 成勇 on 14-5-31.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "CommonTextField.h"

@implementation CommonTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置默认属性
        _m_borderColor = [UIColor clearColor];
        _m_lightBorderColor = [UIColor clearColor];
        _m_lightColor = [UIColor clearColor];
        _m_cornerRadio = 5;
        _m_borderWidth = 2;
        _m_lightSize = 8;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CustomendEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
		[self.layer setCornerRadius:_m_cornerRadio];
		[self.layer setBorderColor:_m_borderColor.CGColor];
		[self.layer setBorderWidth:_m_borderWidth];
		[self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[self setBackgroundColor:[UIColor whiteColor]];
		[self.layer setMasksToBounds:NO];

        // Initialization code
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        _m_borderColor = UIColorFromRGB(166, 166, 166);
//        _m_lightBorderColor = UIColorFromRGB(235,235,235);
//        _m_lightColor = UIColorFromRGB(55,154,255);
        //设置默认属性
        _m_borderColor = [UIColor clearColor];
        _m_lightBorderColor = [UIColor clearColor];
        _m_lightColor = [UIColor clearColor];
        _m_cornerRadio = 5;
        _m_borderWidth = 8;
        _m_lightSize = 8;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CustomendEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
		[self.layer setCornerRadius:_m_cornerRadio];
		[self.layer setBorderColor:_m_borderColor.CGColor];
		[self.layer setBorderWidth:_m_borderWidth];
		[self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[self setBackgroundColor:[UIColor whiteColor]];
		[self.layer setMasksToBounds:NO];
        
    }
    return self;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    
    layer.shadowPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    [layer setBorderWidth: 1.0];
    [layer setBorderColor: [UIColor colorWithWhite:0.1 alpha:0.2].CGColor];
}
- (void)beginEditing:(NSNotification*) notification
{
	[[self layer] setShadowOffset:CGSizeMake(0, 0)];
    [[self layer] setShadowRadius:_m_lightSize];
    [[self layer] setShadowOpacity:1];
    [[self layer] setShadowColor:_m_lightColor.CGColor];
	[self.layer setBorderColor:_m_lightBorderColor.CGColor];
}

- (void)CustomendEditing:(NSNotification*) notification
{
	[[self layer] setShadowOffset:CGSizeZero];
    [[self layer] setShadowRadius:0];
    [[self layer] setShadowOpacity:0];
    [[self layer] setShadowColor:nil];
	[self.layer setBorderColor:_m_borderColor.CGColor];
}
- (CGRect)textRectForBounds:(CGRect)bounds
{
	CGRect inset = CGRectMake(bounds.origin.x + _m_cornerRadio*2,
							  bounds.origin.y,
							  bounds.size.width - _m_cornerRadio*2,
							  bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
	CGRect inset = CGRectMake(bounds.origin.x + _m_cornerRadio*2,
							  bounds.origin.y,
							  bounds.size.width - _m_cornerRadio*2,
							  bounds.size.height);
    return inset;
}


@end
