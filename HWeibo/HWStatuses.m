//
//  HWStatuses.m
//  HWeibo
//
//  Created by devzkn on 7/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWStatuses.h"
#import "MJExtension.h"
#import "HWCreatedAtTool.h"

@implementation HWStatuses
/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls":[HWPhoto class]};
}

/** 
 处理时间格式
 */
- (NSString *)created_at{
    //星期  月份 日期 HH:mm:ss 北京时间正8时区 年份    HH 大写24小时制
//    Sat Sep 24 15:27:52 +0800 2016
    return [HWCreatedAtTool processStatutesCreatedAt:_created_at];
}

- (void)setSource:(NSString *)source{
    //方法一     NSRegularExpression
//方法二 截取  substringWithRange
    if (!source || [source isEqualToString:@""]) {
        _source = @"";
        return;
    }
    NSRange tmpRange;
    tmpRange.location=[source rangeOfString:@">"].location+1;
    tmpRange.length = [source rangeOfString:@"<" options:NSBackwardsSearch].location-tmpRange.location;
    NSString *tmp = [source substringWithRange:tmpRange];
    _source = [@"from " stringByAppendingString:tmp];
}

@end
