//
//  HWIconView.m
//  HWeibo
//
//  Created by devzkn on 9/26/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWIconView.h"
#import "UIImageView+WebCache.h"

@interface HWIconView ()
/** 认证类型图标*/
@property (nonatomic,weak) UIImageView *vImageView;

@end
@implementation HWIconView
- (UIImageView *)vImageView{
    if (nil == _vImageView) {
        UIImage *image = [UIImage imageNamed:@"avatar_default"];
        UIImageView *tmpView = [[UIImageView alloc]initWithImage:image];
        tmpView.width =17;
        tmpView.height =17;
        _vImageView = tmpView;
        [self addSubview:_vImageView];
    }
    return _vImageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
//        self.clipsToBounds = YES;
        //创建V类型ImageView
        self.vImageView.hidden = YES;
    }
    return self;
}

- (void)setUser:(HWUser *)user{
    _user = user;
    [self setupImage:user];
    
}

-(void)setupImage:(HWUser*)user{
    //设置头像
    NSURL *iconImageURL = [ NSURL URLWithString:user.profile_image_url];
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
    [self sd_setImageWithURL:iconImageURL placeholderImage:placeholderImage];
    //设置认证图片
    if (user.verified_type != HWUserVerifiedTypeNone) {
        self.vImageView.hidden = NO;
        self.vImageView.image = user.verified_typeImage;
    }else{
        self.vImageView.hidden = YES;
    }
   
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.user.verified_type != HWUserVerifiedTypeNone) {
        self.vImageView.x = self.width - self.vImageView.width*0.6;
        self.vImageView.y = self.height - self.vImageView.height*0.6;
    }
    
}

@end
