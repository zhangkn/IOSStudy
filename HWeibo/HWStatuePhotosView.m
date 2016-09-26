//
//  HWPhotosView.m
//  HWeibo
//
//  Created by devzkn on 9/25/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWStatuePhotosView.h"
#import "UIImageView+WebCache.h"
#import "HWPhoto.h"
#import "HWStatuePhotoView.h"
/** count为2，4，1 的时候，最大列数为2，否则最大列数为3*/
#define HWStatuesPhotoMaxClos(count) ((count == 2 || count == 4 || count ==1)? 2: 3 )
#define HWStatuesPhotoMargin 5
#define HWStatuesPhotoWH(HWStatuesPhotoMaxClos) (KMainScreenWidth-2*HWStatusCellBorderW- (HWStatuesPhotoMaxClos-1)*HWStatuesPhotoMargin)/HWStatuesPhotoMaxClos

@implementation HWStatuePhotosView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}

- (void)setPic_urls:(NSArray *)pic_urls{
    _pic_urls = pic_urls;
    //创建足够的子控件
    //    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count<pic_urls.count) {
        HWStatuePhotoView *tmp = [[HWStatuePhotoView alloc]init];
        [self addSubview:tmp];
    }
#warning  // 在layoutSubviews 计算内部控件的frame
    //设置内部控件的图片
    [self setupPhotiViewData:pic_urls];
    
}
/**设置内部控件的图片*/
- (void)setupPhotiViewData:(NSArray*)pic_urls{
    
    for (int i =0; i<self.subviews.count; i++) {
        HWStatuePhotoView *photoView = self.subviews[i];
        if (i<pic_urls.count) {
            photoView.hidden = NO;
            photoView.photoModel = pic_urls[i];
        }else{
            photoView.hidden = YES;
        }
    }
}


/**     // 在layoutSubviews 计算内部控件的frame*/
- (void)layoutSubviews{
    [super layoutSubviews];
    long maxCols = HWStatuesPhotoMaxClos(self.pic_urls.count);
    CGFloat wh = HWStatuesPhotoWH(maxCols);

    for (int i =0; i<self.pic_urls.count; i++) {
        //计算photo 所在的列数、行数
        long rows = i/maxCols;
        long clos = i%maxCols;//i%最大的列数
        //计算 photoView 的frame
        UIImageView *photoView = self.subviews[i];
        photoView.x = clos*wh+(clos)*HWStatuesPhotoMargin;  //由列数决定
        photoView.y = rows*wh+(rows)*HWStatuesPhotoMargin;
        photoView.width = wh;
        photoView.height = wh;
    }

}


#pragma mark - 根据图片个数计算size
/** 计算列数、行数,来确定相册的大小*/
- (CGSize)sizeWithPicUrlsCount:(long)count{
    long maxCols = HWStatuesPhotoMaxClos(count);
    CGFloat wh = HWStatuesPhotoWH(maxCols);
    //列数
    long cols = (count>=maxCols) ? maxCols : count;
    CGFloat photoW  = cols*wh +(cols-1)*HWStatuesPhotoMargin;
    //行数
    long rows = (count+maxCols-1)/maxCols;//此公式也适用于分页的页数计算
    CGFloat photoH = rows*wh +(rows-1)*HWStatuesPhotoMargin;
    return CGSizeMake(photoW, photoH);
}
+ (CGSize)sizeWithPicUrlsCount:(long)count{
    return [[[self alloc]init]sizeWithPicUrlsCount:count];
}



@end
