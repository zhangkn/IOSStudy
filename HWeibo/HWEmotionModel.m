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
//#import "NSObject+MJCoding.h"

@implementation HWEmotionModel

NSArray *tmpemojiModelArray;
NSArray *tmpDefaultModelArray;
NSArray *tmpHuahuaModelAray;

+(HWEmotionModel *)getModelWithChs:(NSString *)chs{
    for (HWEmotionModel *obj in [self ListModelWithType:HWEmotionModelTypeDefault]) {
        if ([obj.chs isEqualToString:chs]) {
            return obj;
        }
    }
    for (HWEmotionModel *obj in [self ListModelWithType:HWEmotionModelTypeHuaHua]) {
        if ([obj.chs isEqualToString:chs]) {
            return obj;
        }
    }
    return nil;
}

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


/**
 Encodes the receiver using a given archiver. 归档的时候调用
 说明这个对象的哪些属性进行归档
 */
//- (void)encodeWithCoder:(NSCoder *)aCoder{
//    
////    [aCoder encodeObject:self.chs forKey:@"chs"];
////    [aCoder encodeObject:self.code forKey:@"code"];
////    [aCoder encodeObject:self.png forKey:@"png"];
////    [aCoder encodeObject:self.type forKey:@"type"];
//    
//}
//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
//    self = [super init];
//    if (self) {
////        self.chs=[aDecoder decodeObjectForKey:@"chs"];
////        self.png=[aDecoder decodeObjectForKey:@"png"];
////        self.code=[aDecoder decodeObjectForKey:@"code"];
////        self.type=[aDecoder decodeObjectForKey:@"type"];
//        
//    }
//    return self;
//}// NS_DESIGNATED_INITIALIZER

/**
 归档的实现
 */
MJExtensionCodingImplementation

//- (id)initWithCoder:(NSCoder *)decoder 
//{
//    if (self = [super init]) {
//        [self mj_decode:decoder];
//    }
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [self mj_encode:encoder];
//}


- (BOOL)isEqual:(id)object{
    if (!object) {
        return NO;
    }
   
    HWEmotionModel *tmp = (HWEmotionModel*)object;
    BOOL BTmptype = ([self.type isEqualToString:tmp.type]);
    if ([self.type isEqualToString:@"1"]) {//分成两类别进行比较
       BOOL BTmpCode =  ([self.code isEqualToString: tmp.code]);
        return BTmpCode && BTmptype ;
    }
    BOOL bTmpPng = ( [self.png  isEqualToString: tmp.png]);
    BOOL BTmpChs = ([self.chs isEqualToString:tmp. chs]);
    return bTmpPng  && BTmptype && BTmpChs;
    
   
}


//- (NSUInteger)hash{
//    return [self.png hash]+[self.code hash]+[self.type hash]+[self.type hash];
//}



@end
