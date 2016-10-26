//
//  HWStatusTextPartModel.h
//  HWeibo
//
//  Created by devzkn on 26/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWStatusTextPartModel : NSObject

@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) NSRange range;
@property (nonatomic,assign) BOOL isspecial;

@property (nonatomic,assign) BOOL isEmotion;


//定义初始化方法 KVC的使用
- (instancetype) initWithText:(NSString *) text range:(NSRange)range isspecial:(BOOL)isspecial;
+ (instancetype) statusTextPartModelWithText:(NSString *) text range:(NSRange)range isspecial:(BOOL)isspecial;

+ (NSMutableArray *)statusTextPartModelsWithSpecialPattern:(NSString*)specialPattern text:(NSString*)text;
@end
