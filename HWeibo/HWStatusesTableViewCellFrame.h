//
//  HWStatusesTableViewCellFrame.h
//  HWeibo
//
//  Created by devzkn on 9/19/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWStatuses.h"

#define HWStatusCellBorderW 10
#define HWStatusCellContentViewSpaceW 5
#define HWNameLabelFont [UIFont systemFontOfSize:12]
#define HWTimeLabelFont [UIFont systemFontOfSize:10]


/**
 1.存放一个微博cell 内部控件的frame
 2.存放cell的高度
 3.存放cell对应的数据模型
 */
@interface HWStatusesTableViewCellFrame : NSObject

@property (nonatomic,strong) HWStatuses *statues;
@property (nonatomic,assign) CGFloat cellHeight;
//第1部分： 原创微博控件的frame计算
/** 原创微博控件*/
@property (nonatomic,assign ) CGRect originalViewFrame;
/** 头像*/
@property (nonatomic, assign) CGRect iconViewFrame;
/** 会员图标*/
@property (nonatomic,assign ) CGRect vipViewFrame;
/** 配图*/
@property (nonatomic,assign ) CGRect photoViewFrame;
/** 昵称*/
@property (nonatomic,assign ) CGRect nameLabelFrame;
/** 时间*/
@property (nonatomic,assign ) CGRect timeLabelFrame;
/** 来源*/
@property (nonatomic,assign ) CGRect sourceLabelFrame;
/** 正文*/
@property (nonatomic,assign ) CGRect contentLabelFrame;
//第二部分： 转发控件的frame计算
/** 转发微博整体*/
@property (nonatomic,assign) CGRect repostViewFrame;
/** 转发配图*/
@property (nonatomic,assign) CGRect repostPhotoViewFrame;
/** 转发文本*/
@property (nonatomic,assign) CGRect repostContentLabelFrame;

//第3部分： toolbar的frame计算
/** 工具条整体*/
@property (nonatomic,assign) CGRect toolbarViewFrame;


/**
 提供类方法，返回数据模型数组--工厂模式
 */
+ (NSArray *) listWithHWStatusesArray:(NSArray *)statusesArray;
//定义初始化方法 KVC的使用
- (instancetype) initWithStatuses:(HWStatuses *) statues;
+ (instancetype) statuesFrameWithStatues:(HWStatuses *) statues;

@end
