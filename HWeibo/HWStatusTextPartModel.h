//
//  HWStatusTextPartModel.h
//  HWeibo
//
//  Created by devzkn on 26/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#define HWemojiPattern  @"\\[[a-zA-Z\u4e00-\u9fa5]+\\]"
#define HWuserPattern @"@[0-9a-zA-Z\u4e00-\u9fa5-_-——]+"
#define HWtopicPattern  @"#[0-9a-zA-Z\u4e00-\u9fa5]+#"
#define HWurlPattern @"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"

@interface HWStatusTextPartModel : NSObject

@property (nonatomic,copy) NSString *text;
/** 存储的是特殊字符串在text的range ,用于排序HWStatusTextPartModel*/
@property (nonatomic,assign) NSRange range;
@property (nonatomic,assign) BOOL isspecial;

@property (nonatomic,assign) BOOL isEmotion;


- (instancetype) initWithText:(NSString *) text range:(NSRange)range isspecial:(BOOL)isspecial;
+ (instancetype) statusTextPartModelWithText:(NSString *) text range:(NSRange)range isspecial:(BOOL)isspecial;
/** 根据特殊字符串规则进行对text 进行分组，返回的文字综合为text*/
+ (NSMutableArray *)statusTextPartModelsWithSpecialPattern:(NSString*)specialPattern text:(NSString*)text;

/** 根据特殊字符串规则 获取对应的文字块数组； 返回文字的总和为特殊字符串*/
+ (NSMutableArray *)statusTextPartModelsWithPattern:(NSString*)specialPattern text:(NSString*)text;

@end
