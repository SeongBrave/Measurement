//
//  MenuModel.h
//  Measurement
//
//  Created by DTSoft on 15/2/25.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import <Mantle.h>

@interface MenuModel : MTLModel<MTLJSONSerializing>


/**
 *  des
 */
@property (nonatomic, copy) NSString *des;

/**
 * flag
 */
@property (nonatomic, copy) NSString *flag;

/**
 *isvalidate
 */
@property (nonatomic, copy) NSString *isasmenu;


/**
 *  isvalidate
 */
@property (nonatomic, copy) NSString *isvalidate;

/**
 * menuname
 */
@property (nonatomic, copy) NSString *menuname;

/**
 *menuurl
 */
@property (nonatomic, copy) NSString *menuurl;




/**
 *  name
 */
@property (nonatomic, copy) NSString *name;

/**
 * parentid
 */
@property (nonatomic, copy) NSString *parentid;

/**
 *sysflag
 */
@property (nonatomic, copy) NSString *sysflag;


/**
 *  taskid
 */
@property (nonatomic, copy) NSString *taskid;


@end
