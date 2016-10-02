//
//  HWEmotionModel.m
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmotionModel.h"
#import "MJExtension.h"

@implementation HWEmotionModel

NSArray *tmpemojiModelArray;
NSArray *tmpDefaultModelArray;
NSArray *tmpHuahuaModelAray;

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
