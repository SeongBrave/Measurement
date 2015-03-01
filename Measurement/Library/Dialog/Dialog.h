

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "JGProgressHUD.h"
#import "JFMinimalNotification.h"
#import "RTSpinKitView.h"

typedef enum
{
    MB_ToastType = 0,
    JG_ToastType,
    
} ToastType;

@interface Dialog : NSObject<MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
    
    long long expectedLength;
    long long currentLength;
}

@property(nonatomic , strong)RTSpinKitView *m_spinKitV;
@property(nonatomic , assign) ToastType toastType;
@property(nonatomic , strong)JFMinimalNotification* minimalNotification;

+ (Dialog *)Instance;

+(void)showNotificationWithTitle:(NSString *) title SubTitle:(NSString *) subTitle dismissalDelay:(NSTimeInterval)dismissalDelay IsPresentFromTop:(BOOL) isPresentFromTop ParentView:(UIView *) parentVuew notificationWithStyle:(JFMinimalNotificationStytle)style RightImage:(UIImage *) rightImage;


/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param title            标题
 *  @param subTitle         副标题
 *  @param isPresentFromTop 是否显示顶部
 *  @param style            显示类型
 */
+(void)showNotificationWithTitle:(NSString *) title SubTitle:(NSString *) subTitle IsPresentFromTop:(BOOL) isPresentFromTop notificationWithStyle:(JFMinimalNotificationStytle)style ParentView:(UIView *) parentView;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param title            标题
 *  @param subTitle         副标题
 *  @param style            显示类型
 */
+(void)showNotificationWithTitle:(NSString *) title SubTitle:(NSString *) subTitle notificationWithStyle:(JFMinimalNotificationStytle)style ParentView:(UIView *) parentView;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          提示信息
 *  @param style            显示类型
 */
+(void)showNotificationWithMessage:(NSString *) message notificationWithStyle:(JFMinimalNotificationStytle)style ParentView:(UIView *) parentView;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          默认提示信息
 */
+(void)ShowNotificationWithMessage:(NSString *) message ParentView:(UIView *) parentView;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          成功时提示信息
 */
+(void)SuccessNotificationWithMessage:(NSString *) message ParentView:(UIView *) parentView;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          失败时提示信息
 */
+(void)ErrorNotificationWithMessage:(NSString *) message ParentView:(UIView *) parentView;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          正常时提示信息
 */
+(void)InfoNotificationWithMessage:(NSString *) message ParentView:(UIView *) parentView;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          警告时提示信息
 */
+(void)WarningNotificationWithMessage:(NSString *) message ParentView:(UIView *) parentView;

//提示对话框
+ (void)alert:(NSString *)message;
+ (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message;

-(Dialog *)initWithParentView:(UIView *) parentView;
//类似于Android一个显示框效果
+ (void)toast:(UIViewController *)controller withMessage:(NSString *) message;
+ (void)toast:(NSString *)message;
+(void)toastSuccess;
+(void)toastSuccess:(NSString *) message;
+(void)toastError:(NSString *) message;
+(void)toastError;
+ (void)toast:(NSString *)message andWtihType:(ToastType) toastType;
//显示在屏幕中间
+ (void)toastCenter:(NSString *)message;
//带进度条
+ (void)progressToast:(NSString *)message;

//带遮罩效果的进度条
- (void)gradient:(UIViewController *)controller seletor:(SEL)method;

//显示遮罩
- (void)showProgress:(UIViewController *)controller;

//关闭遮罩
- (void)hideProgress;

//带说明的进度条
- (void)progressWithLabel:(UIViewController *)controller seletor:(SEL)method;

//显示带说明的进度条
- (void)showProgress:(UIViewController *)controller withLabel:(NSString *)labelText;
- (void)showCenterProgressWithLabel:(NSString *)labelText;


#pragma mark -- JFMinimalNotification

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param title            标题
 *  @param subTitle         副标题
 *  @param isPresentFromTop 是否显示顶部
 *  @param style            显示类型
 *  @param rightImage       显示右侧的图片
 */
-(void)showNotificationWithTitle:(NSString *) title SubTitle:(NSString *) subTitle IsPresentFromTop:(BOOL) isPresentFromTop notificationWithStyle:(JFMinimalNotificationStytle)style RightImage:(UIImage *) rightImage;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param title            标题
 *  @param subTitle         副标题
 *  @param isPresentFromTop 是否显示顶部
 *  @param style            显示类型
 */
-(void)showNotificationWithTitle:(NSString *) title SubTitle:(NSString *) subTitle IsPresentFromTop:(BOOL) isPresentFromTop notificationWithStyle:(JFMinimalNotificationStytle)style;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param title            标题
 *  @param subTitle         副标题
 *  @param style            显示类型
 */
-(void)showNotificationWithTitle:(NSString *) title SubTitle:(NSString *) subTitle notificationWithStyle:(JFMinimalNotificationStytle)style;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          提示信息
 *  @param style            显示类型
 */
-(void)showNotificationWithMessage:(NSString *) message notificationWithStyle:(JFMinimalNotificationStytle)style;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          默认提示信息
 */
-(void)ShowNotificationWithMessage:(NSString *) message;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          成功时提示信息
 */
-(void)SuccessNotificationWithMessage:(NSString *) message;
/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          失败时提示信息
 */
-(void)ErrorNotificationWithMessage:(NSString *) message;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          正常时提示信息
 */
-(void)InfoNotificationWithMessage:(NSString *) message;

/**
 *  注意:必须使用 shareInstanceWithParentView 赋值给父类才可以使用
 *
 *  @param message          警告时提示信息
 */
-(void)WarningNotificationWithMessage:(NSString *) message;



#pragma  mark - ShowProgress
/**
 *  网络请求时提示正在加载中
 *
 *  @param message 显示信息
 *  @param style   显示类型
 */
-(void)toastProgressWithMessage:(NSString *) message withStyle:(RTSpinKitViewStyle)style;

/**
 *  网络请求时提示正在加载中
 *
 *  @param message 显示信息
 */
-(void)toastProgressWithMessage:(NSString *) message;

/**
 *  网络请求时提示正在加载中
 */
-(void)toastProgressWithMessage;

@end
