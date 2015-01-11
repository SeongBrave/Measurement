//
//  SignatureViewController.h
//  Measurement
//
//  Created by 凌晨 on 1/2/15.
//  Copyright (c) 2015 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignatureViewController;

@protocol SignatureViewDelegate <NSObject>

-(void)SignatureVC:(SignatureViewController*) signatureVC saveUpWithImage:(UIImage *) img;

@end

@interface SignatureViewController : UIViewController

@property(nonatomic , assign)id<SignatureViewDelegate> m_delegate;

@end
