//
//  HWStatuesToolbar.m
//  HWeibo
//
//  Created by devzkn on 9/23/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWStatuesToolbar.h"
#define HWHWStatuesToolbarFont [UIFont systemFontOfSize:12]
#define HWHWStatuesToolbarTitleEdgeInsets UIEdgeInsetsMake(0, 5, 0, 0)


@interface HWStatuesToolbar ()

@property (nonatomic,weak) UIButton *repostButton;
@property (nonatomic,weak) UIButton *commentButton;
@property (nonatomic,weak) UIButton *likesButton;

@property (nonatomic,weak) UIImageView *cutOffView;
@property (nonatomic,weak) UIImageView *cutOffView1;



@end

@implementation HWStatuesToolbar

- (UIImageView *)cutOffView1{
    if (nil == _cutOffView1) {
        UIImageView *tmpView = [[UIImageView alloc]init];
        _cutOffView1 = tmpView;
        [tmpView setImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:_cutOffView1];
    }
    return _cutOffView1;
}

- (UIImageView *)cutOffView{
    if (nil == _cutOffView) {
        UIImageView *tmpView = [[UIImageView alloc]init];
        _cutOffView = tmpView;
        [tmpView setImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:_cutOffView];
    }
    return _cutOffView;
}

+ (instancetype)statuesToolbarWithStatues:(HWStatuses *)statuses{
    HWStatuesToolbar *tmp = [[HWStatuesToolbar alloc]init];
    tmp.statuses = statuses;
    return tmp;
}

- (void)setStatuses:(HWStatuses *)statuses{
    _statuses = statuses;
    //装配数据
    [self setupButtonData:self.repostButton count:statuses.reposts_count defaultValue:@"Repost"];
    [self setupButtonData:self.commentButton count:statuses.comments_count defaultValue:@"Comments"];
    [self setupButtonData:self.likesButton count:statuses.attitudes_count defaultValue:@"Likes"];
}

- (void)setupButtonData:(UIButton*)btn count:(int)count defaultValue:(NSString*)defaultValue{
    if (count>0) {
        defaultValue = (count <=9999) ? [NSString stringWithFormat:@"%d",count] : [NSString stringWithFormat:@"%dK",(int)(count*0.001)] ;//
        /** Objective-C浮点数转化整数（向上取整、向下取整）*/
//        方法一 (int)(count*0.001)]
//        方法2 floor取得不大于浮点数的最大整数 返回值，是double
//        方法3ceil函数，向上取整
    }
    [btn setTitle:defaultValue forState:UIControlStateNormal];
}

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
    self.cutOffView.frame = CGRectMake(CGRectGetMaxX(self.repostButton.frame), self.repostButton.y, 1, self.repostButton.height);
    self.commentButton.frame = CGRectMake(CGRectGetMaxX(self.repostButton.frame), 0, self.width/3, self.height);
    self.cutOffView1.frame = CGRectMake(CGRectGetMaxX(self.commentButton.frame), self.commentButton.y, 1, self.commentButton.height);
    self.likesButton.frame = CGRectMake(CGRectGetMaxX(self.commentButton.frame), 0, self.width/3, self.height);
    
}

@end
