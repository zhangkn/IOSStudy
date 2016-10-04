//
//  HWEmojiKeyboardEmojiTool.h
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HWEmotionModelTypeEmoji =1,
    HWEmotionModelTypeDefault ,
    HWEmotionModelTypeHuaHua
    
}HWEmotionModelType;

@class HWEmotionModel;
@interface HWEmojiKeyboardEmojiTool : NSObject

/**
 提供类方法，返回数据模型数组--工厂模式
 */


+ (NSArray *) emojiList;
+ (NSArray *) defaultList;
+ (NSArray *) huahuaList;

+ (NSArray *) dictArrayListWithtype:(HWEmotionModelType)type;

/** 保存最近使用的表情*/
+ (void)saveEmotionModel:(HWEmotionModel*)model;
+ (NSMutableArray *)motionModels;


@end
