//
//  NSString+Levenshtein.h
//  uitextFieldTabV
//
//  Created by DTSoft on 15/1/5.
//  Copyright (c) 2015年 山西金仕达软件有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <float.h>

#define LEV_INF_DISTANCE FLT_MAX
@interface NSString (Levenshtein)

- (float) asciiLevenshteinDistanceWithString: (NSString *)stringB;
- (float) asciiLevenshteinDistanceWithString: (NSString *)stringB skippingCharacterSet: (NSCharacterSet *)charset;
@end
