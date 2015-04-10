//
//  FileHelpers.h
//  MClinicalNursing
//
//  Created by 成勇 on 14-4-6.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FileHelpers : NSObject




//取得项目的基本版本信息
+(NSDictionary *)getMyAppVersionInfo;

//根据文件名和文件类型取得文件所在当前项目的路径
/*
 _fileName:表示文件名
 _fileType:表示文件后缀
 */
+(NSString *)GetMainBundlePathWithFileName:(NSString *) _fileName andFileType:(NSString*) _fileType;

//根据文件名和文件类型取得文件所在document资源目录的路径
/*
 _fileName:表示文件名
 _fileType:表示文件后缀
 */
+(NSString *)GetDocumentPathWithFileName:(NSString *) _fileName andFileType:(NSString*) _fileType;

//将字典类型的数据写入document资源目录
/*
 _fileName:表示文件名
 _fileType:表示文件后缀
 */
+(void)WriteDictDataToDocument:(NSMutableDictionary *) _dict WithFileName:(NSString *) _fileName andFileType:(NSString*) _fileType;

//将数组类型的数据写入document资源目录
/*
 _fileName:表示文件名
 _fileType:表示文件后缀
 */
+(void)WriteArrDataToDocument:(NSMutableArray *)_arr WithFileName:(NSString *)_fileName andFileType:(NSString *)_fileType;

//获取字典数据
/*
 _isTrue:表示是否在mainBundle 否则就为Document资源路径下
 _fileName:表示文件名
 _fileType:表示文件后缀
 */
+(NSMutableDictionary *)GetDictDataWithFileName:(NSString *) _fileName andFileType:(NSString*) _fileType andIsMainBundle:(BOOL) _isTrue;

//获取数组数据
/*
 _isTrue:表示是否在mainBundle 否则就为Document资源路径下
 _fileName:表示文件名
 _fileType:表示文件后缀
 */
+(NSMutableArray *)GetArrDataWithFileName:(NSString *) _fileName andFileType:(NSString*) _fileType andIsMainBundle:(BOOL) _isTrue;

//使用NSUserDefaults保存数据
+(void)SaveDataWithNSUserDefaultsForData:(id) _data andWithKey:(NSString*) _key;

//从NSUserDefaults取得保存的数据
+(id)GetDataFromNSUserDefaultsWithKey:(NSString*) _key;

/**
 *  删除某一key对应的值
 *
 *  @param key
 */
+(void)removeNSUserDefaultsDataByKey:(NSString *) key;

/**
 *  读取服务器地址配置信息
 *
 *  @return 服务器地址配置信息字典
 */
+(NSDictionary*)readPreferences;

/**
 *  将服务器地址写入配置文件
 *
 *  @param _dict 服务器地址信息
 */
+(void)writePreferencesWithDict:(NSDictionary*) _dict;

/**
 *  将图片保存到本地
 *
 *  @param key 保存的建
 *
 *  @param  image 需要保存的图片
 */
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key ;

/**
 *  本地是否有相关图片
 *
 *  @param key 保存的建
 *
 *  @return 返回的是否保存有图片
 */
+ (BOOL)LocalHaveImage:(NSString*)key ;
/**
 *  从本地获取图片
 *
 *  @param key 保存的建
 *
 *  @return 返回的图片
 */
+ (UIImage*)GetImageFromLocal:(NSString*)key;


@end
