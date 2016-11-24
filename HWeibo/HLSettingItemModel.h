//
//  HLSettingItemModel.h
//  HisunLottery
//
//  Created by devzkn on 4/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HLSettingItemModelOptionBlock)();

@interface HLSettingItemModel : UIView

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,strong,readonly) UIImage *iconImage;

@property (nonatomic,copy) HLSettingItemModelOptionBlock optionBlock;
@property (nonatomic,copy) NSString *subTitle;


/**
 提供类方法，返回数据模型数组--工厂模式
 */
+ (NSArray *)list:(NSArray *)arrayDict;
//定义初始化方法 KVC的使用
- (instancetype) initWithDictionary:(NSDictionary *) dict;
+ (instancetype) itemModelWithDictionary:(NSDictionary *) dict;

+ (instancetype) itemModelWithTitle:(NSString *) title icon:(NSString *)icon;




@end
