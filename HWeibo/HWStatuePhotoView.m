//
//  HWPhotoView.m
//  HWeibo
//
//  Created by devzkn on 9/25/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWStatuePhotoView.h"
#import "UIImageView+WebCache.h"

@interface HWStatuePhotoView ()

@property (nonatomic,weak) UIImageView *gitView;

@end



@implementation HWStatuePhotoView

+ (instancetype)statuePhotoViewWithPhotoModel:(HWPhoto *)photoModel{
    HWStatuePhotoView *tmp = [[self alloc]init];
    tmp.photoModel = photoModel;
    return tmp;
}

- (UIImageView *)gitView{
    if (nil == _gitView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *tmpView = [[UIImageView alloc]initWithImage:image];
        _gitView = tmpView;
        [self addSubview:_gitView];
    }
    return _gitView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self.gitView setHidden:YES];
        /**UIViewContentModeScaleToFill,      拉伸填充整个UIImageView（可能会变形）
        UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent  按照原来尺寸继续伸缩填充整个UIImageView（不会变形，上下或者左右可能会出现空白部分）
        UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped. 按照原来的尺寸进行拉伸填充，但会超出frame。配合属性使用clipsToBounds 进行裁剪（内容会展示不全） 拉伸到高度（W）与UIImageView的高度（W）一样，就停止拉伸。再居中显示－》部分超出frame
        UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
        UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
        UIViewContentModeTop,
        UIViewContentModeBottom,
        UIViewContentModeLeft,
        UIViewContentModeRight,
        UIViewContentModeTopLeft,
        UIViewContentModeTopRight,
        UIViewContentModeBottomLeft,
        UIViewContentModeBottomRight,
         规律：
         1.凡是带有Scale单词的模式，图片都会拉伸
         2.凡是带有Aspect单词的模式，图片都会保持图片原来的宽高比（图片不会变形）
         
         
         
         */
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;//Setting this value to YES causes subviews to be clipped to the bounds of the receiver.
    }
    return self;
}

- (void)setPhotoModel:(HWPhoto *)photoModel{
    _photoModel = photoModel;
    //装配数据
    
    UIImage *placeholderImage = [UIImage imageNamed:@"timeline_image_placeholder"];
    [self sd_setImageWithURL:[NSURL URLWithString:photoModel.thumbnail_pic] placeholderImage:placeholderImage];
    if ([self isGifImage:photoModel.thumbnail_pic]) {
        self.gitView.hidden = NO;
    }else{
        self.gitView.hidden = YES;
    }
}

- (BOOL)isGifImage:(NSString *)url{
    /**方法一 */
//    NSRange range= [url rangeOfString:@".gif"];
//    return !(range.length == 0 || range.location == NSNotFound);
    /** 方法二*/
    return [url.lowercaseString hasSuffix:@".gif"];
}

/**     //计算子控件的Fram
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    self.gitView.x = self.width- self.gitView.width;
    self.gitView.y = self.height-self.gitView.height;
}


@end
