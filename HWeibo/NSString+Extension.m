//
//  NSString+Extension.m
//  HWeibo
//
//  Created by devzkn on 9/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (NSInteger)fileSize{
    
    if ([self isEqualToString:@""] || self.length == 0 ) {
        return 0;
    }
    //1.判断是否为文件\路径
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExists =  [mgr fileExistsAtPath:self isDirectory:&isDir];
    
    if (!isExists) {
        return 0;
    }
    
    if (!isDir ) {//文件
      return  [[mgr attributesOfItemAtPath:self error:nil][NSFileSize]integerValue];
    }
    
    //2.计算文件夹的内容
    return [self directorySize];
}

- (NSInteger)directorySize{
    NSInteger size=0;
    NSFileManager *mgr = [NSFileManager defaultManager];
    //计算目录大小
    NSArray *subpathsAtcachePath = [mgr subpathsAtPath:self];
    for (NSString *subpath in subpathsAtcachePath ) {
        NSString *fullsubpath = [self stringByAppendingPathComponent:subpath];
        //判断是否为文件
        BOOL isDir = NO;
        [mgr fileExistsAtPath:fullsubpath isDirectory:&isDir];
        if (!isDir) {
            //计算文件大小
            //获取文件属性
            NSError *error;
            NSDictionary *attributesOfItemAtfullsubpath = [mgr attributesOfItemAtPath:fullsubpath error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
            //获取文件大小
            NSInteger fileSize = [attributesOfItemAtfullsubpath[NSFileSize] integerValue];
            
            size += fileSize;
        }else{
            continue;
        }
    }
    return size;
}

-(CGSize) sizeWithTextFont:(UIFont *)font{
    /** 方式一*/
    //    NSDictionary *tmpDict = @{NSFontAttributeName: font};
//       return  [self sizeWithAttributes:tmpDict];
    /** 方式2*/
//    return    [self sizeWithFont:font];//过期，表示不再更新潜在bug，但还是仍可使用
    /** 方式3*/
    return  [self sizeWithFont:font maxW:CGFLOAT_MAX];
}
-(CGSize) sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    CGSize maxSize = CGSizeMake(maxW, CGFLOAT_MAX);
    if (IOSSystemVersion>=7.0) {
        NSDictionary *tmpDict = @{NSFontAttributeName: font};
        return  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:tmpDict context:nil].size;//NS_AVAILABLE(10_11, 7_0); 7.0  才支持
    }else{
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
}

@end
