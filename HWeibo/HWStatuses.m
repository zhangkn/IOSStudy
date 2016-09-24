//
//  HWStatuses.m
//  HWeibo
//
//  Created by devzkn on 7/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWStatuses.h"
#import "HWPhoto.h"
#import "MJExtension.h"

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
    //1. dateFromString
//    _created_at = @"Sat Sep 22 15:27:52 +0800 2016";
    NSString *localeIdentifier =@"en_US";
    NSString *dateformatter=@"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *tmpDate =[self dateFromString:_created_at dateformatter:dateformatter localeIdentifier:localeIdentifier];
//    NSTimeInterval timeInterval =[[NSDate date] timeIntervalSinceDate:tmpDate];//这个方法比较时间 返回的是时间单位second
    
    //2. 判断微博的创建时间 于此时的时间关系    stringFromDate
    NSCalendar *calendar= [NSCalendar currentCalendar];//方便比较两个日期之间差距
    NSComparisonResult result = [calendar compareDate:[NSDate date] toDate:tmpDate toUnitGranularity:NSCalendarUnitYear];
    if (result == NSOrderedSame) {//今年
        //处理今年的时间
        return [self setupDateInThisYear:tmpDate];
    }else{//非今年
        //处理非今年的日期
        return [self stringFromDate:tmpDate dateformatter:@"yyyy-MM-dd HH:mm" localeIdentifier:localeIdentifier];
    }
    
}

#pragma mark - 处理今年的时间
/** 
 //
 处理今年的时间
 */
- (NSString*)setupDateInThisYear:(NSDate*)tmpDate{
    NSCalendar *calendar= [NSCalendar currentCalendar];//方便比较两个日期之间差距
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:tmpDate toDate:[NSDate date] options:NSCalendarWrapComponents];
    NSLog(@"%@",dateComponents);
    if (dateComponents.month == 0 && dateComponents.day == 0) {
        /*1》一天之内的时间处理
        just now                   一分钟之内
        xx min           1 min    一个小时之内（60分钟之内）1-60分钟之内
        x hour ago       1 hour ago   一天之内（24小时之内）1-24小时之内*/
        if (dateComponents.hour < 1 && dateComponents.minute>1) {
            return [NSString stringWithFormat:@"%ld min",dateComponents.minute];
        }else if (dateComponents.hour>=1){
            return [NSString stringWithFormat:@"%ld hour ago",dateComponents.hour];
        }else{
            return @"just now";
        }
    }else if (dateComponents.month == 0 && dateComponents.day== 1){
        /*2》25-48小时后的时间处理（24小时之后）
        yesterday HH:mm  yesterday 17:30  两天之内 （48小时之内）25-48小时之内*/
        return [NSString stringWithFormat:@"yesterday %@",[self stringFromDate:tmpDate dateformatter:@"HH:mm" localeIdentifier:@"en_US"]];
    }else{
        /*3》48小时后的时间处理（其它时间）
        MM-dd HH:mm  09-18 17:30      48小时之后*/
        return [self stringFromDate:tmpDate dateformatter:@"MM-dd HH:mm" localeIdentifier:@"en_US"];
    }
    
}





/**
 dateFromString
 ps:
 localeIdentifier 含义的解释
 /    NSLocale *gbLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
 //    NSString *template = @"yMMMMd";
 //    NSString *enDateFormat = [NSDateFormatter dateFormatFromTemplate:template options:0 locale: gbLocale];
 //    NSLog(@"Date format for %@: %@",
 //          [usLocale displayNameForKey:NSLocaleIdentifier value:[usLocale localeIdentifier]], enDateFormat);
 // Output:
 // Date format for English (United States): MMMM d, y  en_US
 // Date format for English (United Kingdom): d MMMM y  en_GB
 //Date format for 中文（中国）: y年M月d日    zh_CN
 */
- (NSDate*) dateFromString:(NSString*)stringTime dateformatter:(NSString*)dateformatter localeIdentifier:(NSString*)localeIdentifier {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
#warning  真机调试，转换时间 需要设置 NSLocale
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];//zh_CN  en_US en_GB
    [formatter setLocale:usLocale];
    formatter.dateFormat = dateformatter;
    return  [formatter dateFromString:stringTime];
}
- (NSString*) stringFromDate:(NSDate*)date dateformatter:(NSString*)dateformatter localeIdentifier:(NSString*)localeIdentifier {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
#warning  真机调试，转换时间 需要设置 NSLocale
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];//zh_CN  en_US en_GB
    [formatter setLocale:usLocale];
    formatter.dateFormat = dateformatter;
    return  [formatter stringFromDate:date];
}

@end
