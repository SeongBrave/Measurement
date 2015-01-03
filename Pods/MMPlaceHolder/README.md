MMPlaceHolder
=============

A drop in solution to set a placeholder or show UIView's size

[中文介绍](http://adad184.com/2014/08/21/2014-08-21-kai-yuan-xiang-mu-mmplaceholder/)

you can use it for frame debug
![demo](https://raw.githubusercontent.com/adad184/MMPlaceHolder/master/Screenshot/screenshot2.PNG)

or you can use it for size debug
![show](https://raw.githubusercontent.com/adad184/MMPlaceHolder/master/Screenshot/screenshot1.PNG)


Installation
============

The preferred way of installation is via [CocoaPods](http://cocoapods.org). Just add

```ruby
pod 'MMPlaceHolder'
```

and run `pod install`. It will install the most recent version of MMPlaceHolder.

If you would like to use the latest code of MMPlaceHolder use:

```ruby
pod 'MMPlaceHolder', :head
```

Usage
===============

simply, you only need one line code.

```objc
[yourView showPlaceHolder];
```


or you can customize youself.

```objc
@interface  UIView(MMPlaceHolder)

- (void)showPlaceHolder;
- (void)showPlaceHolderWithAllSubviews;
- (void)showPlaceHolderWithAllSubviews:(NSInteger)maxDepth;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor arrowSize:(CGFloat)arrowSize;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor arrowSize:(CGFloat)arrowSize lineWidth:(CGFloat)lineWidth;

- (void)hidePlaceHolder;
- (void)hidePlaceHolderWithAllSubviews;
- 
- (MMPlaceHolder *)getPlaceHolder;

@end
```
	
	
and you can use the global configuration

```objc
@interface MMPlaceHolderConfig : NSObject

+ (MMPlaceHolderConfig*) defaultConfig;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, assign) CGFloat arrowSize;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) BOOL visible;

@end
```


Changelog
===============
v1.6  now you can control the visible of frame & arrow & text by

```objc

	@property (nonatomic, strong) UIColor *frameColor;
	@property (nonatomic, assign) CGFloat frameWidth;

	[MMPlaceHolderConfig defaultConfig].showArrow = YES;
	[MMPlaceHolderConfig defaultConfig].showText = YES;
```
      and modified the function `hidePlaceHolder` & add new function `removePlaceHolder`
      
```objc
	- (void)removePlaceHolder;
	- (void)removePlaceHolderWithAllSubviews;
```
      most important thing is you can automatic display the placeholder with one line code by
      
```objc
    [MMPlaceHolderConfig defaultConfig].autoDisplay = YES;
```


v1.5  fix hidePlaceHolder bug when subviews shows placeholder


v1.4  add a demo project & now you can config the global visability by

```objc
    [MMPlaceHolderConfig defaultConfig].visible = NO;
```
    

v1.3  now you can add placeholders recursively by

```objc
    - (void)showPlaceHolderWithAllSubviews;
    - (void)showPlaceHolderWithAllSubviews:(NSInteger)maxDepth;
    - (void)hidePlaceHolderWithAllSubviews;
```


v1.2  now you can change default configuration by `[MMPlaceHolderConfig defaultConfig]`

```objc
    [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor whiteColor];
    [MMPlaceHolderConfig defaultConfig].backColor = [UIColor clearColor];
    [MMPlaceHolderConfig defaultConfig].arrowSize = 3;
    [MMPlaceHolderConfig defaultConfig].lineWidth = 1;
```


v1.1  now you can get or remove `MMPlaceHolder` by 

```objc
    - (void)hidePlaceHolder;
    - (MMPlaceHolder *)getPlaceHolder;
```


v1.0  you can custom or simply use it by

```objc
    - (void)showPlaceHolder;
    - (void)showPlaceHolderWithLineColor:(UIColor*)lineColor;
    - (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor;
    - (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor arrowSize:(CGFloat)arrowSize ;
    - (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor arrowSize:(CGFloat)arrowSize lineWidth:(CGFloat)lineWidth;
```


