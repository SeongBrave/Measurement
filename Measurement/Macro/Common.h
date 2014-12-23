//
//  Common.h
//  LongCaiApp
//
//  Created by lc on 13-11-28.
//  Copyright (c) 2013年 LongCai. All rights reserved.
//




#ifndef Nav_common_h
#define Nav_common_h NSLog(@"%s %d %s", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__);

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;
//=================
// DLog will output like NSLog only when the DEBUG variable is set
// ALog will always output like NSLog
// ULog will show the UIAlertView only when the DEBUG variable is set

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#ifdef DEBUG
#define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif

#define UShowInfo(fmt1,fmt2 ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:fmt1] message:[NSString stringWithFormat:fmt2]  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]; [alert show]; }



//=======================================
// Uncomment the defitions to show additional info.

#define __GOODMAO_DEBUG__

//#define DEBUGWHERE_SHOWFULLINFO
//#define DEBUG_SHOWLINES
//#define DEBUG_SHOWFULLPATH
//#define DEBUG_SHOWSEPARATORS
#define DEBUG_SHOWFULLINFO


// Definition of DEBUG functions. Only work if DEBUG is defined.


#ifdef __GOODMAO_DEBUG__

#define debug_separator() NSLog( @"────────────────────────────────────────────────────────────────────────────" );

#ifdef DEBUG_SHOWSEPARATORS
#define debug_showSeparators() debug_separator();
#else
#define debug_showSeparators()
#endif

/// /// /// ////// /////

#ifdef DEBUG_SHOWFULLPATH
#define debug_whereFull() debug_showSeparators(); NSLog(@"Line:%d : %s : %s", __LINE__,__FILE__,__FUNCTION__); debug_showSeparators();
#else
#define debug_whereFull() debug_showSeparators(); NSLog(@"Line:%d : %s : %s", __LINE__,[ [ [ [NSString alloc] initWithBytes:__FILE__ length:strlen(__FILE__) encoding:NSUTF8StringEncoding] lastPathComponent] UTF8String ] ,__FUNCTION__); debug_showSeparators();
#endif

/// /// /// ////// /////

#define debugExt(args,...) debug_separator(); debug_whereFull(); NSLog( args, ##__VA_ARGS__); debug_separator();

/// /// /// ////// ///// Debug Print Macros

#ifdef DEBUG_SHOWFULLINFO
#define debug(args,...) debugExt(args, ##__VA_ARGS__);
#else
#ifdef DEBUG_SHOWLINES
#define debug(args,...) debug_showSeparators(); NSLog([ NSString stringWithFormat:@"Line:%d : %@", __LINE__, args ], ##__VA_ARGS__); debug_showSeparators();
#else
#define debug(args,...) debug_showSeparators(); NSLog(args, ##__VA_ARGS__); debug_showSeparators();
#endif
#endif




/// /// /// ////// ///// Debug Specific Types

#define debug_object( arg ) debug( @"Object: %@", arg );
#define debug_int( arg ) debug( @"integer: %i", arg );
#define debug_float( arg ) debug( @"float: %f", arg );
#define debug_rect( arg ) debug( @"CGRect ( %f, %f, %f, %f)", arg.origin.x, arg.origin.y, arg.size.width, arg.size.height );
#define debug_point( arg ) debug( @"CGPoint ( %f, %f )", arg.x, arg.y );
#define debug_size( arg ) debug( @"CGSize ( %f, %f )", arg.width, arg.height );
#define debug_bool( arg )   debug( @"Boolean: %@", ( arg == YES ? @"YES" : @"NO" ) );



/// /// /// ////// ///// Debug Where Macros

#ifdef DEBUGWHERE_SHOWFULLINFO
#define debug_where() debug_whereFull();
#else
#define debug_where() debug(@"%s",__FUNCTION__);
#endif

#define debug_where_separators() debug_separator(); debug_where(); debug_separator();

/// /// /// ////// /////

#else
#define debug(args,...)
#define debug_separator()
#define debug_where()
#define debug_where_separators()
#define debug_whereFull()
#define debugExt(args,...)
#define debug_object( arg )
#define debug_int( arg )
#define debug_rect( arg )
#define debug_bool( arg )
#define debug_point( arg )
#define debug_float( arg )
#endif


#endif

