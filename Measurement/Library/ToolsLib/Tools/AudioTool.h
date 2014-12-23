//
//  AudioTool.h
//  BedsNursingApp
//
//  Created by dt on 14-7-8.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioTool : NSObject


@property(nonatomic , strong)AVAudioPlayer *m_Player;

+(void)vibrate;


//播放对应文件的音频
-(void)voicePromptWithStr:(NSString *) str;

+(AudioTool *)getInstance;
@end
