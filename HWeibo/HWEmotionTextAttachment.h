//
//  HWEmotionTextAttachment.h
//  HWeibo
//
//  Created by devzkn on 04/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWEmotionModel.h"

@interface HWEmotionTextAttachment : NSTextAttachment

@property (nonatomic,strong) HWEmotionModel *model;

/**
 提供类方法，返回数据模型数组--工厂模式
*/
- (instancetype) initWithEmotionModel:(HWEmotionModel*)model;
- (NSString*)getChs;

+ (instancetype) initWithEmotionModel:(HWEmotionModel*)model;


@end
