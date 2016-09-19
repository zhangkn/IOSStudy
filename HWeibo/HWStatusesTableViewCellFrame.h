//
//  HWStatusesTableViewCellFrame.h
//  HWeibo
//
//  Created by devzkn on 9/19/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWStatuses.h"
/**
 1.存放一个微博cell 内部控件的frame
 2.存放cell的高度
 3.存放cell对应的数据模型
 */
@interface HWStatusesTableViewCellFrame : NSObject

@property (nonatomic,strong) HWStatuses *statues;
@property (nonatomic,assign) CGFloat cellHeight;
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

@end
