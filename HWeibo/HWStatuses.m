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



//- (void)setAttributedText:(NSAttributedString *)attributedText{
//    
//}

- (void)setText:(NSString *)text{
    _text = [text copy];
    [self setAttributedTextWithText:text];
}


- (void)setAttributedTextWithText:(NSString *)text{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
//    处理特殊文字
    //表情【英文+中文】
//    [self matchesInStringWithRegularExpression:@"\\[[a-zA-Z\u4e00-\u9fa5]+\\]" text:text];
    //@用户昵称
//    [self matchesInStringWithRegularExpression:@"@[0-9a-zA-Z\u4e00-\u9fa5]+" text:text];
    //话题##
//    [self matchesInStringWithRegularExpression:@"#[0-9a-zA-Z\u4e00-\u9fa5]+#" text:text];
    //超找表情、话题、用户昵称
//    [self matchesInStringWithRegularExpression:@"#[0-9a-zA-Z\u4e00-\u9fa5]+#|@[0-9a-zA-Z\u4e00-\u9fa5]+|\\[[a-zA-Z\u4e00-\u9fa5]+\\]" text:text];
    //匹配链接
    NSString *pattern = @"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]";//? 代表0 或者1个
    [self matchesInStringWithRegularExpression:pattern text:text];
    
    self.attributedText = attributedText;

}

- (void)matchesInStringWithRegularExpression:(NSString *)pattern  text:(NSString*)text{
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc]initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regularExpression matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    for (NSTextCheckingResult *obj in results) {
        NSLog(@"%@",[text  substringWithRange:obj.range]);
    }
    
}



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
