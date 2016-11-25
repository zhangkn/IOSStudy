//
//  HWClearCacheTool.m
//  HWeibo
//
//  Created by devzkn on 25/11/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "HWClearCacheTool.h"
#import "NSString+Extension.h"

@implementation HWClearCacheTool



+ (double)getCacheDirSize{
    double size ;
    
    //获取cache路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",cachePath);
   
    size = [cachePath fileSize];
    size = (size*0.001*0.001);//M 为单位
    return size;
    
}

+ (void)clearCacheDir{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    [[NSFileManager defaultManager] removeItemAtPath:cachePath error:nil];
}

@end
