//
//  HWClearCacheTool.h
//  HWeibo
//
//  Created by devzkn on 25/11/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWClearCacheTool : NSObject

/** 计算路径大小M*/
+ (double)getCacheDirSize;

+ (void)clearCacheDir;


@end
