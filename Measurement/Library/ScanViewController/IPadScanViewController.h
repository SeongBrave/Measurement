//
//  IPadScanViewController.h
//
//
//  Created by DTSoft on 15/1/18.
//  Copyright (c) 2015年 SeongBrave-App-工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@class IPadScanViewController;

@protocol IPadScanViewControllerDelegate <NSObject>

-(void)IPadScanVC:(IPadScanViewController*) ipadScanVC DidScanViewWithStr:(NSString *) resultValue;

-(void)IPadScanVC:(IPadScanViewController*) ipadScanVC DidCancleClick:(UIButton *) CancleBtn;

-(void)IPadScanVC:(IPadScanViewController*) ipadScanVC DidSkipClick:(UIButton *) skinBtn;


@end

@interface IPadScanViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic , assign)id<IPadScanViewControllerDelegate> m_ScanDelegate;

@property(nonatomic , strong)AVCaptureDevice *m_device;

@property(nonatomic , strong)AVCaptureDeviceInput *m_input;

@property(nonatomic , strong)AVCaptureMetadataOutput *m_output;

@property(nonatomic , strong)AVCaptureSession *m_session;

@property(nonatomic , strong)AVCaptureVideoPreviewLayer *m_preview;

@property(nonatomic , assign) BOOL isFromLoginVC;  //是否是推送进来的


-(id)initWithDelegate:(id<IPadScanViewControllerDelegate>) _mydelegate;

@end
