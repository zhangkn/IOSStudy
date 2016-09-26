//
//  HWPhotosView.h
//  HWeibo
//
//  Created by devzkn on 9/25/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 微博的配图相册 控件*/
@interface HWStatuePhotosView : UIView
/** 数据模型*/
@property (nonatomic,strong) NSArray *pic_urls;

- (CGSize)sizeWithPicUrlsCount:(long)count;
/** 根据相册的图片个数，计算相册的size*/
+ (CGSize)sizeWithPicUrlsCount:(long)count;


@end
