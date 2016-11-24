//
//  HLHtmlModel.h
//  HisunLottery
//
//  Created by devzkn on 4/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 "title" : "如何购彩？",
 "html" : "help.html",
 "id" : "howtobuy"
 */
@interface HLHtmlModel : UIView
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *html;
@property (nonatomic,copy) NSString *ID;
/**
 提供类方法，返回数据模型数组--工厂模式
 */
+ (NSArray *) list;
//定义初始化方法 KVC的使用
- (instancetype) initWithDictionary:(NSDictionary *) dict;
+ (instancetype) htmlWithDictionary:(NSDictionary *) dict;



@end
