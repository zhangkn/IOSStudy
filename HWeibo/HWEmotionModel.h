//
//  HWEmotionModel.h
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HWEmojiKeyboardEmojiTool.h"


@interface HWEmotionModel : NSObject




/** <dict>
 <key>chs</key>
 <string>[笑哈哈]</string>
 <key>cht</key>
 <string>[笑哈哈]</string>
 <key>gif</key>
 <string>lxh_xiaohaha.gif</string>
 <key>png</key>
 <string>lxh_xiaohaha.png</string>
 <key>type</key>
 <string>0</string>
	</dict>*/

/** 表情的文字描述*/
@property (nonatomic,copy) NSString *chs;
/** 表情的png 图片名称*/
@property (nonatomic,copy) NSString *png;

/** emoji 表情的16进制*/
@property (nonatomic,copy) NSString *code;

/** 表情的l类型  type = 1, 只有code 字段； type = 0 ，有chs,png 字段*/
@property (nonatomic,copy) NSString *type;

/**
 提供类方法，返回数据模型数组--工厂模式  返回的是临时变量
 */
+ (NSArray *) ListModelWithType:(HWEmotionModelType)emotionModelType;
/** 获取全局变量的模型数组*/
+ (NSArray *)getSituationListModelWithType:(HWEmotionModelType)emotionModelType;

//定义初始化方法 KVC的使用
//- (instancetype) initWithDictionary:(NSDictionary *) dict;
//+ (instancetype) <#name#>WithDictionary:(NSDictionary *) dict;



@end
