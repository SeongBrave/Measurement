//
//  ScanViewController.h
//  AVCaptureDemo
//
//  Created by 成勇 on 14-5-6.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


typedef void(^ScanViewControllerHandler)(NSString *ScanVC);

@protocol ScanViewControllerDelegate <NSObject>

-(void)DidScanViewWithStr:(NSString *) _resultValue;

@end

@interface ScanViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic , strong) UILabel *m_titleLabel;      //正在执行的扫描提示
@property(nonatomic , strong) UIButton *m_openFlashLightBtn;  //打开闪光灯
@property(nonatomic , strong) UIButton *m_cancelBtn;
@property(nonatomic , strong) UIImageView *m_ScanBGImgV;   //扫描背景框
@property(nonatomic , strong) NSString *m_titleStr;  //保存扫描要提示的内容


@property(nonatomic , assign)id<ScanViewControllerDelegate> m_ScanDelegate;
@property(nonatomic , strong)AVCaptureDevice *m_device;

@property(nonatomic , strong)AVCaptureDeviceInput *m_input;

@property(nonatomic , strong)AVCaptureMetadataOutput *m_output;

@property(nonatomic , strong)AVCaptureSession *m_session;

@property(nonatomic , strong)AVCaptureVideoPreviewLayer *m_preview;

@property(nonatomic , assign) BOOL isFromLoginVC;  //是否是推送进来的

-(id)initWithHander:(ScanViewControllerHandler) Handler;

-(id)initWithDelegate:(id<ScanViewControllerDelegate>) _mydelegate;
//+(ScanViewController *)getScanInstanceWithHandler:(ScanViewControllerHandler) Handler andScanType:(ScanType) _scanType;

@end
