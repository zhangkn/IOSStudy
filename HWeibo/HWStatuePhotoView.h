//
//  HWPhotoView.h
//  HWeibo
//
//  Created by devzkn on 9/25/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWPhoto.h"
/** 配图控件 如果是动画，就提示用户  http://ww4.sinaimg.cn/thumbnail/74e489f9gw1f85qqb5414g209w05ktyi.gif*/
@interface HWStatuePhotoView : UIImageView

//自定义视图的现实的数据来源于模型，即使用模型装配自定义视图的显示内容
@property (nonatomic,strong) HWPhoto *photoModel;//视图对应的模型，是视图提供给外界的接口
/**
 通过数据模型设置视图内容，可以让视图控制器不需要了解视图的细节
 */
+ (instancetype) statuePhotoViewWithPhotoModel:(HWPhoto *) photoModel;


@end
