//
//  HWStatuesToolbar.h
//  HWeibo
//
//  Created by devzkn on 9/23/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWStatuses.h"
@interface HWStatuesToolbar : UIView

//自定义视图的现实的数据来源于模型，即使用模型装配自定义视图的显示内容
@property (nonatomic,strong) HWStatuses *statuses;//视图对应的模型，是视图提供给外界的接口
+ (instancetype) statuesToolbar;
/**
 通过数据模型设置视图内容，可以让视图控制器不需要了解视图的细节
 */
+ (instancetype) statuesToolbarWithStatues:(HWStatuses *) statuses;


@end
