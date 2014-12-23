//
//  VendorMacro.h
//  MClinicalNursing
//
//  Created by 成勇 on 14-4-4.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

//放一些第三方常量
#ifndef MClinicalNursing_VendorMacro_h
#define MClinicalNursing_VendorMacro_h


#pragma mark - 界面 部分

#define NavigationBar_HEIGHT 44     //导航控制器

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)      //屏幕宽度

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)    //屏幕高度


#define RBGCOLOR(r,g,b) [UIColor colorWithRed:0.400 green:0.523 blue:0.949 alpha:1.000]  //设置颜色

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


// rgb颜色转换（16进制->10进制）
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#pragma mark - 系统 部分

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]   //当前设备的系统版本
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])     //当前的系统版本
#define IS_IOS6() [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])   //当前的设备的默认语言

#define isRetina ([[UIScreen mainScreen] scale]== 2 ? YES : NO)    //是否是高清屏

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)    //是否是IPhone5

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) //是否是IPAD


#pragma mark - Block
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#pragma mark - 图片，返回UIImage
#define LoadCacheImage(name) [UIImage imageNamed:name]
#define LoadDiskImage(name)  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]]


#define USER_DEFAULT [NSUserDefaults standardUserDefaults]      //UserDefault


#define degreesToRadian(x) (M_PI * (x) / 180.0) //弧度转角度

#define radianToDegrees(radian) (radian*180.0)/(M_PI)  //角度转弧度



//读取本地图片的 和imageNamed一样，但是性能比后者要强很多，两个参数，前面一个是 文件名，后面一个是类型

#define LoadImage(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]  //可以用来直接传图片名字

#define LoadImageWithType(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]


#pragma mark - Path
#define kHomePath        NSHomeDirectory()
#define kCachePath      [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]
#define kDocumentFolder [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kDocumentFolder2 [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define kLibraryPath [NSHomeDirectory() stringByAppendingPathComponent:@"Library"]
#define kTempPath    NSTemporaryDirectory()
#define kMainBoundPath [[NSBundle mainBundle] bundlePath]
#define kResourcePath  [[NSBundle mainBundle] resourcePath]
#define kExecutablePath [[NSBundle mainBundle] executablePath]


#pragma mark - Setting
//当前系统设置国家的country iso code
#define countryISO  [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode]
//当前系统设置语言的iso code
#define languageISO [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode]

//static NSString *(^CountryNameByISO)(NSString *) = ^(NSString *iso) {
//    NSLocale *locale = [NSLocale currentLocale];
//    return [locale displayNameForKey:NSLocaleCountryCode value:iso];
//};
//
//static NSString *(^ISOCountryCodeByCarrier)() = ^() {
//    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
//    return [carrier isoCountryCode];
//};

#define SIMISO                  ISOCountryCodeByCarrier()
#define CountryNameFromISO(iso) CountryNameByISO(iso)


#pragma mark - 单例
#define DeclareSingletonInterface(className)  \
+ (classname *)shared##classname

#define ImplementSingletonInterface(className) \
+ (classname *)shared##classname { \
static dispatch_once_t onceToken = 0; \
static id sharedInstance = nil; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[self alloc] init]; \
}); \
return sharedInstance; \
}


#pragma mark - 功能部分
#ifdef DEBUG
#   define DLog(...) NSLog((@"%s [Line %d] %@"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#   define SLog(...) NSLog(__VA_ARGS__)
#else
#   define DLog(...)
#   define SLog(...)
#endif
//SLog(kMainBoundPath, nil);

//针对真机iPhone
#if TARGET_OS_IPHONE
//iPhone Device
#endif

//针对模拟器
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#define SAFE_RELEASE(x) x = nil
#else
// compiling without ARC
#define SAFE_RELEASE(x) [x release];x=nil
#endif


#endif
