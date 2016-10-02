//
//  HWEmojiKeyboardEmojiTool.m
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmojiKeyboardEmojiTool.h"
/** 负责加载表情数据*/
@implementation HWEmojiKeyboardEmojiTool

+ (NSArray *)dictArrayListWithtype:(HWEmotionModelType)type{
    switch (type) {
        case HWEmotionModelTypeEmoji:
            return [self emojiList];
//            break;
        case HWEmotionModelTypeHuaHua:
            return [self huahuaList];
//            break;
        case HWEmotionModelTypeDefault:
            return [self defaultList];
//            break;
    }
}

+ (NSArray *)defaultList{
    NSString *strName = @"EmotionIcons/default/info.plist";
    return [self listWithStrName:strName];
}
+ (NSArray *)huahuaList{
    NSString *strName = @"EmotionIcons/lxh/info.plist";
    return [self listWithStrName:strName];
}
+ (NSArray *)emojiList{
    NSString *strName = @"EmotionIcons/emoji/info.plist";
    return [self listWithStrName:strName];
}
+ (NSArray*)listWithStrName:(NSString*)strName{
    NSString *tmppath = [[NSBundle mainBundle] pathForResource:strName ofType:nil];
    NSArray *tmp = [NSArray arrayWithContentsOfFile:tmppath];
    return tmp;
}

@end
