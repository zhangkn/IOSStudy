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

static NSMutableArray *_emotionModelArray;

+ (void)initialize{
    //第一次使用这个类的时候，才加载一次沙盒文件
    _emotionModelArray = [NSKeyedUnarchiver unarchiveObjectWithFile:HWEmotionArchivePath];
    if (_emotionModelArray == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _emotionModelArray = [NSMutableArray array];//只创建一次
        });
    }
}
/** 时时保存信息到沙盒*/
+ (void)saveEmotionModel:(HWEmotionModel *)model{
    //保存到沙盒
    //先添加到数组，再保存数组
    _emotionModelArray = [self motionModels];
    if ([_emotionModelArray containsObject:model]) {
        //将当前的表情移动到第一个
        [_emotionModelArray removeObject:model];
    }
    [_emotionModelArray insertObject:model atIndex:0];
    [NSKeyedArchiver archiveRootObject:_emotionModelArray toFile:HWEmotionArchivePath];
}
/** 返回全局变量的最近表情数组*/
#pragma mark - /** 返回全局变量的最近表情数组*/
+ (NSMutableArray *)motionModels{
    return _emotionModelArray;
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
