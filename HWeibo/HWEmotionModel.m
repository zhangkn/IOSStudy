//
//  HWEmotionModel.m
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmotionModel.h"
#import "MJExtension.h"
#import "HWEmotionTextAttachment.h"

@implementation HWEmotionModel

NSArray *tmpemojiModelArray;
NSArray *tmpDefaultModelArray;
NSArray *tmpHuahuaModelAray;

+ (NSMutableAttributedString *)emotionMutableAttributedStringWithModel:(HWEmotionModel *)model font:(UIFont *)font{
    NSMutableAttributedString *str= [[NSMutableAttributedString alloc]init];
    NSAttributedString *tmp;//模型表情数据
    if ([model.type isEqualToString:@"0"]) {
        //图片数据
        HWEmotionTextAttachment *textAttachment = [HWEmotionTextAttachment initWithEmotionModel:model];
        textAttachment.bounds = CGRectMake(0, -3.5,font.lineHeight, font.lineHeight);
        tmp =  [NSAttributedString attributedStringWithAttachment:textAttachment] ;
    }else if([model.type isEqualToString:@"1"]){//emoji
        NSString *stremoji =[model.code emoji];
        tmp = [[NSMutableAttributedString alloc]initWithString:stremoji];
    }
    //合并数据
    [str appendAttributedString:tmp];
    NSRange range ;
    range.location = 0;
    range.length = str.length;
   [str addAttribute:NSFontAttributeName value:font range:range];
    return str ;
}

+ (NSArray*)getTmpemojiModelArray{
    if (!tmpemojiModelArray) {
        tmpemojiModelArray = [self arrayModelWithDictArray:[HWEmojiKeyboardEmojiTool dictArrayListWithtype:HWEmotionModelTypeEmoji]];
    }
    return tmpemojiModelArray;
}

+ (NSArray*)getTmpDefaultModelArray{
    if (!tmpDefaultModelArray) {
        tmpDefaultModelArray = [self arrayModelWithDictArray:[HWEmojiKeyboardEmojiTool dictArrayListWithtype:HWEmotionModelTypeDefault]];
    }
    return tmpDefaultModelArray;
}

+ (NSArray*)getTmpHuahuaModelAray{
    if (!tmpHuahuaModelAray) {
        tmpHuahuaModelAray = [self arrayModelWithDictArray:[HWEmojiKeyboardEmojiTool dictArrayListWithtype:HWEmotionModelTypeHuaHua]];
    }
    return tmpHuahuaModelAray;
}


+ (NSArray *)ListModelWithType:(HWEmotionModelType)emotionModelType{
    
    return [self arrayModelWithDictArray:[HWEmojiKeyboardEmojiTool dictArrayListWithtype:emotionModelType]];
}

+ (NSArray *)getSituationListModelWithType:(HWEmotionModelType)emotionModelType{
    switch (emotionModelType) {
        case HWEmotionModelTypeDefault:
            return [self getTmpDefaultModelArray];
        case HWEmotionModelTypeHuaHua:
            return [self getTmpHuahuaModelAray];
        case HWEmotionModelTypeEmoji:
            return [self getTmpemojiModelArray];
    }
}

+ (NSArray *)arrayModelWithDictArray:(NSArray*)tmpDictArray{
    return [self mj_objectArrayWithKeyValuesArray:tmpDictArray];
}


@end
