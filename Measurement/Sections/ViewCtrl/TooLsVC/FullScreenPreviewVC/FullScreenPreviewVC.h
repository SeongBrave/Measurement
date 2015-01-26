//
//  FullScreenPreviewVC.h
//  Measurement
//
//  Created by DTSoft on 15/1/27.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "BaseViewController.h"

@interface FullScreenPreviewVC : BaseViewController

@property(nonatomic ,strong) NSString *m_urlStr;

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@end
