//
//  HWEmojiTabbar.m
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmojiTabbar.h"

#import "HWEmojiTabbarButton.h"

@interface HWEmojiTabbar ()

@property (nonatomic,weak) HWEmojiTabbarButton *recentBtn;
@property (nonatomic,weak) HWEmojiTabbarButton *defaultBtn;
@property (nonatomic,weak) HWEmojiTabbarButton *emojiBtn;
@property (nonatomic,weak) HWEmojiTabbarButton *huahuaBtn;

@property (nonatomic,strong) HWEmojiTabbarButton *selectedButton;

@property (nonatomic,weak) UIView *partitionOffView;




@end

@implementation HWEmojiTabbar

- (UIView *)partitionOffView{
    if (nil == _partitionOffView) {
        UIView *tmpView = [[UIView alloc]init];
        _partitionOffView = tmpView;
        [self addSubview:_partitionOffView];
    }
    return _partitionOffView;
}

- (HWEmojiTabbarButton *)recentBtn{
    if (nil == _recentBtn) {
        HWEmojiTabbarButton *tmpView = [self buttonWithTitle:@"Recent"];
        _recentBtn = tmpView;
        [self addSubview:_recentBtn];
    }
    return _recentBtn;
}
- (HWEmojiTabbarButton *)defaultBtn{
    if (nil == _defaultBtn) {
        HWEmojiTabbarButton *tmpView = [self buttonWithTitle:@"Default"];
        _defaultBtn = tmpView;
        [self addSubview:_defaultBtn];
    }
    return _defaultBtn;
}
- (HWEmojiTabbarButton *)emojiBtn{
    if (nil == _emojiBtn) {
        HWEmojiTabbarButton *tmpView = [self buttonWithTitle:@"Emoji"];
        _emojiBtn = tmpView;
        [self addSubview:_emojiBtn];
    }
    return _emojiBtn;
}
- (HWEmojiTabbarButton *)huahuaBtn{
    if (nil == _huahuaBtn) {
        HWEmojiTabbarButton *tmpView = [self buttonWithTitle:@"HuaHua"];
        _huahuaBtn = tmpView;
        [self addSubview:_huahuaBtn];
    }
    return _huahuaBtn;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.width/(self.subviews.count-1);
    for (int i = 0; i<self.subviews.count-1; i++) {
        HWEmojiTabbarButton *btn = self.subviews[i];
        btn.width =w;
        btn.height = self.height;
        btn.x = w*i;
        btn.y = 0;
    }
    self.partitionOffView.width = self.width;
    self.partitionOffView.height = 1;
    self.partitionOffView.y =0;
    self.partitionOffView.x = 0;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView{
    self.recentBtn.tag =  HWEmojiTabbarButtonTypeRecent;
    self.defaultBtn.tag =  HWEmojiTabbarButtonTypeDefault;
    self.emojiBtn.tag = HWEmojiTabbarButtonTypeEmoji;
    self.huahuaBtn.tag =  HWEmojiTabbarButtonTypeHuaHua;
    self.partitionOffView.backgroundColor = [UIColor grayColor];
    for (HWEmojiTabbarButton *obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            obj.selected = NO;
        }
    }
    
}
/** 设置默认的表情界面 方法一：在willMoveToSuperview 之前设置代理对象*/
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    //默认选中 default按钮
    if (newSuperview && self.delegate) {
        [self clickButton:self.defaultBtn];        
    }
}

/** 设置默认的表情界面 方法二：保证代理对象在 初始化keybar完成之前设置delegate*/
- (void)setDelegate:(id<HWEmojiTabbarDelegate>)delegate{
    _delegate = delegate;
    if (delegate) {
        [self clickButton:self.defaultBtn];
    }
}

- (HWEmojiTabbarButton*)buttonWithTitle:(NSString*)title{
    HWEmojiTabbarButton *tmp = [[HWEmojiTabbarButton alloc]init];
    [tmp setTitle:title forState:UIControlStateNormal];
//    NSString *normalImageName = @"compose_emotion_table_left_selected";
//    NSString *selectedImageName = @"compose_emotion_table_left_normal";
//    [tmp setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
//    [tmp setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [tmp addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];//用于控制按钮的状态;
    return tmp;
}

- (void)clickButton:(HWEmojiTabbarButton*)btn{
    
    if (self.selectedButton == btn || btn == nil) {//方法二： 采用enabl状态进行控制，而非selected
        return;
    }
    self.selectedButton.selected = NO;
    btn.selected = YES;
    self.selectedButton = btn;
    //通知代理对象切换表情
    if ([self.delegate respondsToSelector:@selector(emojiTabbar:didSelectedEmojiType:)]) {
        [self.delegate emojiTabbar:self didSelectedEmojiType:btn.tag];
    }
}

@end
