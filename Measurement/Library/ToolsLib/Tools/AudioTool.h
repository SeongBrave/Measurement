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


/**
 *  播放对应文件的音频
 *
 *  @param str 默认格式为wav
 */
-(void)voicePromptWithStr:(NSString *) str;

/**
 *  播放对应文件的音频
 *
 *  @param str strType 格式的
 */
-(void)voicePromptWithStr:(NSString *) str andWithType:(NSString *) strType;

+(AudioTool *)getInstance;
@end
