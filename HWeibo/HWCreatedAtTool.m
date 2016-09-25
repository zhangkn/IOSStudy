//
//  HWCreatedAtTool.m
//  HWeibo
//
//  Created by devzkn on 9/25/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWCreatedAtTool.h"

@implementation HWCreatedAtTool
+ (NSString *)processStatutesCreatedAt:(NSString *)created_at{
    //1. dateFromString
    return [[[HWCreatedAtTool alloc ] init ] processStatutesCreatedAt:created_at];
}

- (NSString *)processStatutesCreatedAt:(NSString *)created_at{
    //    _created_at = @"Sat Sep 29 15:27:52 +0800 2015";
    NSString *localeIdentifier =@"en_US";
    NSString *dateformatter=@"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *tmpDate =[self dateFromString:created_at dateformatter:dateformatter localeIdentifier:localeIdentifier];
    //2. 判断微博的创建时间 于此时的时间关系    stringFromDate
    if ([self isThisYear:tmpDate]) {//今年
        //处理今年的时间
        return [self setupDateInThisYear:tmpDate];
    }else{//非今年
        //处理非今年的日期
        return [self stringFromDate:tmpDate dateformatter:@"yyyy-MM-dd HH:mm" localeIdentifier:localeIdentifier];
    }
}

/** 与当前时间的比较，判断是否今年*/
- (BOOL)isThisYear:(NSDate*) tmpDate{
    //    NSTimeInterval timeInterval =[[NSDate date] timeIntervalSinceDate:tmpDate];//这个方法比较时间 返回的是时间单位second
    NSCalendar *calendar= [NSCalendar currentCalendar];//方便比较两个日期之间差距
    /** 方法一*/
    NSComparisonResult result = [calendar compareDate:[NSDate date] toDate:tmpDate toUnitGranularity:NSCalendarUnitYear];
    /*方法二*/
    //    calendar components:<#(NSCalendarUnit)#> fromDate:<#(nonnull NSDate *)#>
    return result == NSOrderedSame;
}

- (BOOL)isYesterDay:(NSDateComponents*)dateComponents{
    return dateComponents.month == 0 && dateComponents.day == 1 && dateComponents.year == 0;
    
}
- (BOOL)isToday:(NSDateComponents*)dateComponents{
    return dateComponents.month == 0 && dateComponents.day == 0 && dateComponents.year == 0;
}
/** 获取两个时间的 NSDateComponents*/
- (NSDateComponents*)dateComponentsWithFromDate:(NSDate*)tmpDate toDate:(NSDate*)toDate calendarUnit:(NSCalendarUnit)calendarUnit{
    NSCalendar *calendar= [NSCalendar currentCalendar];//方便比较两个日期之间差距
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:tmpDate toDate:toDate options:NSCalendarWrapComponents];
    NSLog(@"%@",dateComponents);
    return dateComponents;
}

#pragma mark - 处理今年的时间
/**
 //
 处理今年的时间
 */
- (NSString*)setupDateInThisYear:(NSDate*)tmpDate{
    NSCalendarUnit calendarUnit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *dateComponents = [self dateComponentsWithFromDate:tmpDate toDate:[NSDate date] calendarUnit:calendarUnit];
    if ([self isToday:dateComponents]) {
        /**1》一天之内的时间处理*/
        return [self setupTodayTime:dateComponents];
    }else if ([self isYesterDay:dateComponents]){
        /*2》25-48小时后的时间处理（24小时之后）
         yesterday HH:mm  yesterday 17:30  两天之内 （48小时之内）25-48小时之内*/
        return [NSString stringWithFormat:@"yesterday %@",[self stringFromDate:tmpDate dateformatter:@"HH:mm" localeIdentifier:@"en_US"]];
    }else{
        /*3》48小时后的时间处理（其它时间）
         MM-dd HH:mm  09-18 17:30      48小时之后*/
        return [self stringFromDate:tmpDate dateformatter:@"MM-dd HH:mm" localeIdentifier:@"en_US"];
    }
    
}
/**1》一天之内的时间处理
 just now                   一分钟之内
 xx min           1 min    一个小时之内（60分钟之内）1-60分钟之内
 x hour ago       1 hour ago   一天之内（24小时之内）1-24小时之内*/
- (NSString*)setupTodayTime:(NSDateComponents*)dateComponents{
    if (dateComponents.hour < 1 && dateComponents.minute>1) {
        return [NSString stringWithFormat:@"%ld min",dateComponents.minute];
    }else if (dateComponents.hour>=1){
        return [NSString stringWithFormat:@"%ld hour ago",dateComponents.hour];
    }else{
        return @"just now";
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
