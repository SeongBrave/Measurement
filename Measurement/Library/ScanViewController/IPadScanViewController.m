//
//  IPadScanViewController.m
//
//
//  Created by DTSoft on 15/1/18.
//  Copyright (c) 2015年 SeongBrave-App-工作室. All rights reserved.
//

#import "IPadScanViewController.h"
#import "AudioToolbox/AudioToolbox.h"
#import "NSLayoutConstraint+ClassMethodPriority.h"
#import "FileHelpers.h"
#import "Dialog.h"
#import"Common.h"
#import"UtilsMacro.h"
#import "NotificationMacro.h"
#import"VendorMacro.h"
#import <Masonry/Masonry.h>
#import "BottomTabBarView.h"

#define IPadScanView_showInfoLABEL_FONT  [UIFont fontWithName:@"Helvetica" size:12]
#define IPadScanView_TitleLABEL_FONT  [UIFont fontWithName:@"Helvetica" size:18]

#define IPadScanView_BGView_Color  [UIColor colorWithWhite:0.000 alpha:0.470]

#define IPadScanView_centerView_Height 300
#define IPadScanView_centerView_Width 500

#define IPadScanView_lineView_Height 10

@interface IPadScanViewController ()<BottomTabBarViewDelegate>
{
    
    Dialog * showDialog;
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    UIImageView *lineImgView;  //上下移动的线
    
    CGFloat lineImgViewY;
    NSLayoutConstraint *oldConstraint;  //保存上次加上的NSLayoutConstraint
    
    UIButton *scanButton;
    UILabel *showInfoLabel;  //显示信息
    NSString *oldStrValue;
    
    
    NSString *strValue;
}

@property(nonatomic , strong)UIView *m_centerView;
@property(nonatomic , strong)UIView *m_lineView;
@end

@implementation IPadScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self layoutScanViewControllerView];
    showDialog = [[Dialog alloc]init];
    
    if (IS_IOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    lineImgViewY = 12;
    [self layoutScanViewControllerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    
    
    _m_output.metadataObjectTypes =_m_output.availableMetadataObjectTypes;
    
    // Preview
    
    [_m_session startRunning];
    [showDialog hideProgress];
    num = 4;
    
    upOrdown = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(UpAndDownAnimation) userInfo:nil repeats:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [showDialog showProgress:self withLabel:@"正在初始化摄像头..."];
    [self.navigationController setNavigationBarHidden:YES];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification object:self];
}


-(void)viewWillDisappear:(BOOL)animated
{
    //进入扫描腕带界面时隐藏了navgationbar所以需要重新显示
    [self.navigationController setNavigationBarHidden:NO];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
-(void)OrientationDidChange:(NSNotification *) notification
{
    
    _m_preview.connection.videoOrientation =[UIDevice currentDevice].orientation;
    
//    AVCaptureVideoOrientation newOrientation;
//    switch ([[UIDevice currentDevice] orientation]) {
//        case UIDeviceOrientationPortrait:
//            newOrientation = AVCaptureVideoOrientationPortrait;
//            break;
//        case UIDeviceOrientationPortraitUpsideDown:
//            newOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
//            break;
//        case UIDeviceOrientationLandscapeLeft:
//            newOrientation = AVCaptureVideoOrientationLandscapeRight;
//            break;
//        case UIDeviceOrientationLandscapeRight:
//            newOrientation = AVCaptureVideoOrientationLandscapeLeft;
//            break;
//        default:
//            newOrientation = AVCaptureVideoOrientationPortrait;
//    }
//    _m_preview.connection.videoOrientation = newOrientation;
}
-(id)initWithDelegate:(id<IPadScanViewControllerDelegate>) _mydelegate
{
    self = [super init];
    if (self) {
        
        if (_mydelegate) {
            self.m_ScanDelegate = _mydelegate;
            
            oldStrValue = @""; //用于与扫描后的stringvalue做比较如果不相同则调用block
            
        }
        
    }
    return self;
}

-(void)layoutScanViewControllerView
{
    UIView *headBarView = [[UIView alloc]init];
    
    headBarView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:headBarView];
    
    [headBarView mas_makeConstraints:^(MASConstraintMaker *maker){
    
        maker.top.equalTo(self.view.mas_top);
        maker.centerX.equalTo(self.view.mas_centerX);
        maker.leading.equalTo(self.view.mas_leading);
        maker.height.equalTo(@75);
        
    }];
    
    BottomTabBarView *bottomTabBarView = [[BottomTabBarView alloc]initWithBottomTabBarViewDelegate:self];
    
    bottomTabBarView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:bottomTabBarView];
    
    [bottomTabBarView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.bottom.equalTo(self.view.mas_bottom);
        maker.centerX.equalTo(self.view.mas_centerX);
        maker.leading.equalTo(self.view.mas_leading);
        maker.height.equalTo(@75);
        
    }];
    
    [bottomTabBarView layoutCustomSubView];
    
    [bottomTabBarView layoutIfNeeded];
    
    UILabel *headBarTitleLabel = [[UILabel alloc]init];
    headBarTitleLabel.textAlignment = NSTextAlignmentCenter;
    headBarTitleLabel.contentMode = UIViewContentModeScaleAspectFit;
    headBarTitleLabel.textColor = UIColorFromRGB(85, 83, 80);
    headBarTitleLabel.text = @"条形码扫描";
    headBarTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:28];
    [headBarView addSubview:headBarTitleLabel];
    
    [headBarTitleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.top.equalTo(headBarView.mas_top).offset(19);
        maker.bottom.equalTo(headBarView.mas_bottom).offset(-21);
        maker.centerX.equalTo(headBarView.mas_centerX);
        
    }];
    
    
    self.m_centerView = [[UIView alloc]init];
    self.m_centerView.backgroundColor = [UIColor clearColor];
    self.m_centerView.layer.borderWidth = 8.0;
    self.m_centerView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:_m_centerView];
    
    [self.m_centerView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.height.equalTo(@IPadScanView_centerView_Height);
        maker.width.equalTo(@IPadScanView_centerView_Width);
        maker.centerY.equalTo(self.view.mas_centerY);
        maker.centerX.equalTo(self.view.mas_centerX);
        
    }];
    
    self.m_lineView = [[UIView alloc]init];
    self.m_lineView.backgroundColor = UIColorFromRGB(12, 230, 54);
    [self.m_centerView addSubview:_m_lineView];
    
    [self.m_lineView mas_makeConstraints:^(MASConstraintMaker *maker){
        
 
        maker.leading.equalTo(self.m_centerView.mas_leading).offset(80);
        maker.height.equalTo(@IPadScanView_lineView_Height);
        maker.top.equalTo(self.m_centerView.mas_top).offset(10);
        maker.centerX.equalTo(self.m_centerView.mas_centerX);
        
    }];
    
    
    
    UIView *topBGView = [[UIView alloc]init];
    
    topBGView.backgroundColor = IPadScanView_BGView_Color;
    
    [self.view addSubview:topBGView];
    
    [topBGView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.top.equalTo(headBarView.mas_bottom).offset(0);
        maker.leading.equalTo(self.view.mas_leading).offset(0);
        maker.centerX.equalTo(self.view.mas_centerX);
        maker.bottom.equalTo(self.m_centerView.mas_top).offset(0);
        
    }];
    
    UIView *leftBGView = [[UIView alloc]init];
    
    leftBGView.backgroundColor = IPadScanView_BGView_Color;
    
    [self.view addSubview:leftBGView];
    
    [leftBGView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.top.equalTo(topBGView.mas_bottom).offset(0);
        maker.leading.equalTo(self.view.mas_leading).offset(0);
        maker.trailing.equalTo(self.m_centerView.mas_leading).offset(0);
        maker.bottom.equalTo(bottomTabBarView.mas_top).offset(0);
        
    }];
    
    UIView *rightBGView = [[UIView alloc]init];
    
    rightBGView.backgroundColor = IPadScanView_BGView_Color;
    
    [self.view addSubview:rightBGView];
    
    [rightBGView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.top.equalTo(topBGView.mas_bottom).offset(0);
        maker.trailing.equalTo(self.view.mas_trailing).offset(0);
        maker.leading.equalTo(self.m_centerView.mas_trailing).offset(0);
        maker.bottom.equalTo(bottomTabBarView.mas_top).offset(0);
        
    }];
    
    
    UIView *bottomBGView = [[UIView alloc]init];
    
    bottomBGView.backgroundColor = IPadScanView_BGView_Color;
    
    [self.view addSubview:bottomBGView];
    
    [bottomBGView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.top.equalTo(self.m_centerView.mas_bottom).offset(0);
        maker.trailing.equalTo(rightBGView.mas_leading).offset(0);
        maker.leading.equalTo(leftBGView.mas_trailing).offset(0);
        maker.bottom.equalTo(bottomTabBarView.mas_top).offset(0);
        
    }];
    

    //添加扫描相关
    
    _m_device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _m_input = [AVCaptureDeviceInput deviceInputWithDevice:self.m_device error:nil];
    
    // Output
    _m_output = [[AVCaptureMetadataOutput alloc]init];
    [_m_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _m_session = [[AVCaptureSession alloc]init];
    [_m_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_m_session canAddInput:self.m_input])
    {
        [_m_session addInput:self.m_input];
    }
    
    if ([_m_session canAddOutput:self.m_output])
    {
        [_m_session addOutput:self.m_output];
    }
    
    
    _m_preview =[AVCaptureVideoPreviewLayer layerWithSession:self.m_session];
    _m_preview.connection.videoOrientation =[UIDevice currentDevice].orientation;
    
    _m_preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _m_preview.frame = CGRectMake(0, 0, 1024, 768);
    [self.view.layer insertSublayer:self.m_preview atIndex:0];
}
-(void)ClickFlashLight:(id)sender
{
    UIButton *flashLightBtn = (UIButton*)sender;
    flashLightBtn.selected = !flashLightBtn.selected;
    
    
    [self turnTorchOn:flashLightBtn.selected];
}
//打开闪关灯
- (void) turnTorchOn: (bool) on {
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                // torchIsOn = YES;
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                //torchIsOn = NO;
            }
            [device unlockForConfiguration];
        }
    }
}
-(void)UpAndDownAnimation
{
    if (upOrdown == NO) {
        num ++;
        lineImgViewY = num *2;
        if (num == (IPadScanView_centerView_Height -IPadScanView_lineView_Height -5*2*2)/2) {
            upOrdown = YES;
        }
        
        [self.m_lineView mas_updateConstraints:^(MASConstraintMaker *maker){
            
            maker.top.equalTo(self.m_centerView.mas_top).offset(lineImgViewY);
            
        }];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.m_centerView layoutIfNeeded];
        }];
    }
    else {
        --num;
        if (num == 5) {
            upOrdown = NO;
        }
        lineImgViewY = num*2;
        [self.m_lineView mas_updateConstraints:^(MASConstraintMaker *maker){
            
            maker.top.equalTo(self.m_centerView.mas_top).offset(lineImgViewY);
            
        }];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.m_centerView layoutIfNeeded];
        }];
    }
}



-(void)CancelClick:(id)sender
{
    if (self.isFromLoginVC) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    
    WEAKSELF
    //如果stringValue存在并且oldStrValue不是同一个则符合条件
    if (![oldStrValue isEqualToString:stringValue]&& stringValue) {
        
        [weakSelf vibrate];
        
        
        if (self.isFromLoginVC) {
            
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                
                if ([self.m_ScanDelegate respondsToSelector:@selector(IPadScanVC:DidScanViewWithStr:)])
                {
                    [self.m_ScanDelegate IPadScanVC:self DidScanViewWithStr:stringValue];

                }
                
            }];
        }else
        {
            
            [self.m_ScanDelegate IPadScanVC:self DidScanViewWithStr:stringValue];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        strValue = stringValue;
        oldStrValue = stringValue;
        
        [self.m_session stopRunning];
    }
    
    
}

- (void)vibrate   {
    
    
     AudioServicesPlaySystemSound(1002);
    
    if ([[FileHelpers GetDataFromNSUserDefaultsWithKey:@"IsVoicePrompt"] boolValue]) {
        
       
    }
    
}

-(void)bottomTabBarView:(BottomTabBarView*) TabBarView didSaveClick:(UIButton *) sender
{
    if ([self.m_ScanDelegate respondsToSelector:@selector(IPadScanVC:DidSkipClick:)]) {
        [self.m_ScanDelegate IPadScanVC:self DidSkipClick:sender];
    }
}
-(void)bottomTabBarView:(BottomTabBarView*) TabBarView didCancleClick:(UIButton *) sender
{
    if ([self.m_ScanDelegate respondsToSelector:@selector(IPadScanVC:DidCancleClick:)]) {
        [self.m_ScanDelegate IPadScanVC:self DidCancleClick:sender];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
