//
//  HWEmojiKeyboardEmojiTool.m
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmojiKeyboardEmojiTool.h"
#import "HWEmotionModel.h"

#define HWEmotionArchivePath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"emotion.archive"]

/** 负责加载表情数据*/
@implementation HWEmojiKeyboardEmojiTool

+ (void)saveEmotionModel:(HWEmotionModel *)model{
    //保存到沙盒
    //先添加到数组，再保存数组
    NSMutableArray *tmp = [NSMutableArray array];
    NSMutableArray *motionModels = [self motionModels];
    if (motionModels) {
        tmp = [self motionModels];
    }
    if ([tmp containsObject:model]) {
        return;
    }
    [tmp insertObject:model atIndex:0];
    [NSKeyedArchiver archiveRootObject:tmp toFile:HWEmotionArchivePath];
}

#pragma mark - 获取帐号信息
+ (NSMutableArray *)motionModels{
    //    NSDictionary *accountDict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSMutableArray *motionModels = [NSKeyedUnarchiver unarchiveObjectWithFile:HWEmotionArchivePath];
    NSLog(@"%@",HWEmotionArchivePath);
    return motionModels;
}



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
