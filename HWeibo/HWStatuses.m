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
#import "HWStatusTextPartModel.h"
#import "HWEmotionModel.h"
#import "HWSpecialTextPart.h"


@implementation HWStatuses

/** 构建转发微博信息*/
- (void)setRetweeted_status:(HWStatuses *)retweeted_status{
    _retweeted_status = retweeted_status;
    NSString *tmp = [NSString stringWithFormat:@"@%@:%@",retweeted_status.user.name,retweeted_status.text];
    retweeted_status.text = tmp;
    
}
//- (void)setAttributedText:(NSAttributedString *)attributedText{
//    
//}

- (void)setText:(NSString *)text{
    _text = [text copy];
    [self setAttributedTextWithText:text];//使用第三方框架RegexKitLite 进行检索
}


- (void)setAttributedTextWithText:(NSString *)text{
   
//   1. 处理特殊文字的颜色
//    NSMutableAttributedString *attributedText = [self setupColorAttributedTextWithText:text];
    //2.处理表情
    NSMutableAttributedString *attributedText= [self setupColorAndEmotionAttributedTextWithText:text];
    [attributedText addAttribute:NSFontAttributeName value:HWNameLabelFont range:NSMakeRange(0, attributedText.length)];
    self.attributedText = attributedText;

}
#pragma mark - 图文混排相关方法
- (NSMutableAttributedString*)setupColorAndEmotionAttributedTextWithText:(NSString *)text {
    //1. 获取分块文本数组
    NSMutableArray *statusTextPartModels = [HWStatusTextPartModel statusTextPartModelsWithSpecialPattern:[self specialPattern] text:text];    
    //2.拼接属性文本信息
    return [self processStatusTextPartModels:statusTextPartModels];
}
#define HWSpecialStringColor HWColor(138, 186, 244)
/** 分文本的种类进行处理*/
- (NSMutableAttributedString*)processStatusTextPartModels:(NSMutableArray*)statusTextPartModels{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
    NSMutableArray *specialRannges = [[NSMutableArray alloc]init];
    for (HWStatusTextPartModel *obj in statusTextPartModels) {
        NSMutableAttributedString *substr;
        if (obj.isEmotion) {
            //处理表情
            substr = [self processEmotionWithHWStatusTextPartModel:obj];
        }else if(obj.isspecial){
            //处理颜色
            substr = [self setNSMutableAttributedStringColor:obj.text color:HWSpecialStringColor];
            //确定在attributedText的range
            NSRange isspecialRannge = NSMakeRange(attributedText.length, obj.text.length);            
            [specialRannges addObject:[HWSpecialTextPart specialTextPartWithText:obj.text range:isspecialRannge]];
        }else{
           substr =[self setNSMutableAttributedStringColor:obj.text color:nil];
        }
        [attributedText appendAttributedString:substr];
    }
    self.specialRannges = specialRannges;
    return attributedText;
}

- (NSMutableAttributedString*)setNSMutableAttributedStringColor:(NSString*)text color:(UIColor*)color{
    NSMutableAttributedString *attributedString= [[NSMutableAttributedString alloc]initWithString:text];
    if (color) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,text.length)];
    }
    return attributedString;
}

/** 处理表情文字*/
- (NSMutableAttributedString*)processEmotionWithHWStatusTextPartModel:(HWStatusTextPartModel *)obj {
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
    NSString *imageName = [HWEmotionModel getModelWithChs:obj.text].png;
    if (!imageName) {
        return [self setNSMutableAttributedStringColor:obj.text color:HWSpecialStringColor];
    }
    textAttachment.image = [UIImage imageNamed:imageName];
    textAttachment.bounds = CGRectMake(0, -3, HWNameLabelFont.lineHeight, HWNameLabelFont.lineHeight);//设置表情的位置
    NSAttributedString *textAttachmentattributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
     NSMutableAttributedString *substr = [[NSMutableAttributedString alloc]initWithAttributedString:textAttachmentattributedString];
    return substr;
}

- (NSMutableAttributedString*)setupColorAttributedTextWithText:(NSString *)text {
     NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
   
    //    [self matchesInStringWithRegularExpression:pattern text:text];
    
    [text enumerateStringsMatchedByRegex:[self specialPattern] usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        [attributedText addAttribute:NSForegroundColorAttributeName value:HWColor(138, 186, 244) range:*capturedRanges];
    }];
    return attributedText;
}

- (NSString*)specialPattern{
    //表情【英文+中文】
    NSString *emojiPattern = HWemojiPattern;
    //@用户昵称
    NSString *userPattern =HWuserPattern;
    //话题##
    NSString *topicPattern =HWtopicPattern;
    //匹配链接
    NSString *urlPattern=  HWurlPattern;   //超找表情、话题、用户昵称
    //    [self matchesInStringWithRegularExpression:@"#[0-9a-zA-Z\u4e00-\u9fa5]+#|@[0-9a-zA-Z\u4e00-\u9fa5]+|\\[[a-zA-Z\u4e00-\u9fa5]+\\]" text:text];
    
    NSString *pattern =[NSString stringWithFormat:@"%@|%@|%@|%@",emojiPattern,userPattern,topicPattern,urlPattern];//? 代表0 或者1个
    return pattern;
    
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
