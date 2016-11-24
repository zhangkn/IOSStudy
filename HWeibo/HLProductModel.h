//
//  HLProductModel.h
//  HisunLottery
//
//  Created by devzkn on 4/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 
 "title": "网易新闻",
 "id": "com.netease.news",
 "url": "http://itunes.apple.com/app/id425349261?mt=8",
 "icon": "newsapp@2x.png",
 "customUrl": "newsapp"

 */
@interface HLProductModel : UIView
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,strong,readonly) UIImage *iconImage;
@property (nonatomic,copy) NSString *customUrl;

/**
 提供类方法，返回数据模型数组--工厂模式
 */
+ (NSArray *) list;
//定义初始化方法 KVC的使用
- (instancetype) initWithDictionary:(NSDictionary *) dict;
+ (instancetype) productModelWithDictionary:(NSDictionary *) dict;


@end
