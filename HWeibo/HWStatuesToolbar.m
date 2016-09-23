//
//  HWStatuesToolbar.m
//  HWeibo
//
//  Created by devzkn on 9/23/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWStatuesToolbar.h"
#define HWHWStatuesToolbarFont [UIFont systemFontOfSize:12]
#define HWHWStatuesToolbarTextColor HWColor(147, 147, 147)
#define HWHWStatuesToolbarTitleEdgeInsets UIEdgeInsetsMake(0, 5, 0, 0)


@interface HWStatuesToolbar ()

@property (nonatomic,weak) UIButton *repostButton;
@property (nonatomic,weak) UIButton *commentButton;
@property (nonatomic,weak) UIButton *likesButton;


@end

@implementation HWStatuesToolbar

- (UIButton *)repostButton{
    if (nil == _repostButton) {
        UIButton *tmpView = [[UIButton alloc]init];
        _repostButton = tmpView;
        [self setuptoolbarButton:tmpView];
       //        [tmpView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"]]];
        [self addSubview:_repostButton];
    }
    return _repostButton;
}
#pragma mark - 动态控制按钮的选中状态
- (void)didselectedButton:(UIButton*)btn{
    btn.selected = !btn.selected ;
    if (btn.selected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateSelected];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background"] forState:UIControlStateNormal];
    }
}
- (UIButton *)commentButton{
    if (nil == _commentButton) {
        UIButton *tmpView = [[UIButton alloc]init];
        _commentButton = tmpView;
        [self setuptoolbarButton:tmpView];
        [self addSubview:_commentButton];
    }
    return _commentButton;
}

- (UIButton *)likesButton{
    if (nil == _likesButton) {
        UIButton *tmpView = [[UIButton alloc]init];
        _likesButton = tmpView;
        [self setuptoolbarButton:tmpView];
        [self addSubview:_likesButton];
    }
    return _likesButton;
}
#pragma mark - 设置按钮的共同属性
- (void)setuptoolbarButton:(UIButton*)tmpView{
    tmpView.titleLabel.font = HWHWStatuesToolbarFont;
    tmpView.contentMode = UIViewContentModeCenter;
    tmpView.titleEdgeInsets = HWHWStatuesToolbarTitleEdgeInsets;
    [tmpView setTitleColor:HWHWStatuesToolbarTextColor forState:UIControlStateNormal];
    [tmpView addTarget:self action:@selector(didselectedButton:) forControlEvents:UIControlEventTouchUpInside];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //构建内部3个按钮（repost、comment、likes）／／frame的设置，需要在layoutSubviews
        [self.repostButton setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
        [self.repostButton setTitle:@"Repost" forState:UIControlStateNormal];//默认为转发
         [self.commentButton setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
        [self.commentButton setTitle:@"Comments" forState:UIControlStateNormal];//默认为comment
         [self.likesButton setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
        [self.likesButton setTitle:@"Likes" forState:UIControlStateNormal];//默认为likes
        
    }
    return self;
}

+ (instancetype)statuesToolbar{
    return [[self alloc]init];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.repostButton.frame = CGRectMake(0, 0, self.width/3, self.height);
    self.commentButton.frame = CGRectMake(CGRectGetMaxX(self.repostButton.frame), 0, self.width/3, self.height);
    self.likesButton.frame = CGRectMake(CGRectGetMaxX(self.commentButton.frame), 0, self.width/3, self.height);
    
}

@end
