//
//  HWEmojiKeyboard.m
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmojiKeyboard.h"
#import "HWEmojiTabbar.h"
#import "HWEmojiListView.h"
#import "HWEmotionModel.h"
@interface HWEmojiKeyboard ()<HWEmojiTabbarDelegate>

@property (nonatomic,weak) HWEmojiTabbar *emojiTabbar;

@property (nonatomic,strong) HWEmojiListView *emojiListView;
@property (nonatomic,strong) HWEmojiListView *recentListView;
@property (nonatomic,strong) HWEmojiListView *defaultListView;
@property (nonatomic,strong) HWEmojiListView *huahuaListView;

@property (nonatomic,strong) HWEmojiListView *selectedListView;

@end



/** 表情键盘控件*/
@implementation HWEmojiKeyboard

- (HWEmojiListView *)emojiListView{
    if (nil == _emojiListView) {
        HWEmojiListView *tmpView = [[HWEmojiListView alloc]init];
        _emojiListView = tmpView;
        tmpView.hidden = YES;
//        tmpView.backgroundColor = [UIColor redColor];
//        _emojiListView.emotions = [HWEmotionModel ListModelWithType:HWEmotionModelTypeEmoji];
        _emojiListView.emotions = [HWEmotionModel getSituationListModelWithType:HWEmotionModelTypeEmoji];
        [self addSubview:_emojiListView];
    }
    return _emojiListView;
}

- (HWEmojiListView *)huahuaListView{
    if (nil == _huahuaListView) {
        HWEmojiListView *tmpView = [[HWEmojiListView alloc]init];
        _huahuaListView = tmpView;
        tmpView.hidden = YES;
//        tmpView.backgroundColor = [UIColor blueColor];
//       _defaultListView.emotions = [HWEmotionModel ListModelWithType:HWEmotionModelTypeHuaHua];
        _huahuaListView.emotions = [HWEmotionModel getSituationListModelWithType:HWEmotionModelTypeHuaHua];
        [self addSubview:_huahuaListView];
    }
    return _huahuaListView;
}

- (HWEmojiListView *)defaultListView{
    if (nil == _defaultListView) {
        HWEmojiListView *tmpView = [[HWEmojiListView alloc]init];
        _defaultListView = tmpView;
        tmpView.hidden = YES;
//        tmpView.backgroundColor = [UIColor yellowColor];
//        _defaultListView.emotions = [HWEmotionModel ListModelWithType:HWEmotionModelTypeDefault];
        _defaultListView.emotions = [HWEmotionModel getSituationListModelWithType:HWEmotionModelTypeDefault];

        [self addSubview:_defaultListView];
    }
    return _defaultListView;
}

- (HWEmojiListView *)recentListView{
    if (nil == _recentListView) {
        HWEmojiListView *tmpView = [[HWEmojiListView alloc]init];
        _recentListView = tmpView;
        tmpView.hidden = YES;
//        tmpView.backgroundColor = [UIColor blackColor];
        [self addSubview:_recentListView];
    }
    return _recentListView;
}



- (HWEmojiTabbar *)emojiTabbar{
    if (nil == _emojiTabbar) {
        HWEmojiTabbar *tmpView = [[HWEmojiTabbar alloc]init];
        _emojiTabbar = tmpView;
        [self addSubview:_emojiTabbar];
    }
    return _emojiTabbar;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置自己的属性
        self.backgroundColor = [UIColor whiteColor];
        //构建子控件
        [self setupSubView];
        
    }
    return self;
}

- (void) setupSubView{
    [self.emojiTabbar setBackgroundColor:[UIColor clearColor]];
    self.emojiTabbar.delegate = self;
}

#pragma mark - HWEmojiTabbarDelegate
- (void)emojiTabbar:(HWEmojiTabbar *)emojiTabbar didSelectedEmojiType:(HWEmojiTabbarButtonType)emojiTabbarButtonType{
    //切换表情。
//    修改listView d的表情数据
    NSLog(@"%s",__func__);
    
    switch (emojiTabbarButtonType) {
        case HWEmojiTabbarButtonTypeEmoji:{
            //获取数据，进行表情切换
            [self showListView:self.emojiListView];
            break;
        }
        case HWEmojiTabbarButtonTypeHuaHua:{
            [self showListView:self.huahuaListView];
           
            break;
        }
        case HWEmojiTabbarButtonTypeRecent:{
            [self showListView:self.recentListView];
           
            break;
        }
        case HWEmojiTabbarButtonTypeDefault:{
            [self showListView:self.defaultListView];
            break;
        }
    }
}

- (void)showListView:(HWEmojiListView*)selectedListView{
    self.selectedListView.hidden = YES;
//    [self.selectedListView removeFromSuperview];
    self.selectedListView = selectedListView;
    self.selectedListView.hidden = NO;
//    [self addSubview:self.selectedListView];
}
#warning w hen you want to adjust the layout of a view’s subviews. [self setNeedsLayout]; 会在恰当的时候进行layoutSubviews
/** //    self updateFocusIfNeeded
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    //计算子控件的frame
    self.emojiTabbar.x = 0;
    self.emojiTabbar.width = self.width;
    self.emojiTabbar.height = 44;
    self.emojiTabbar.y = self.height- self.emojiTabbar.height;
    //计算listView 的frame
    if (self.selectedListView) {
        self.selectedListView.x = 0;
        self.selectedListView.width = self.width;
        self.selectedListView.height = self.emojiTabbar.y;
        self.selectedListView.y = 0;
    }
//    self.huahuaListView.frame = self.emojiListView.frame;
//    self.defaultListView.frame = self.emojiListView.frame;
//    self.recentListView.frame = self.emojiListView.frame;
}



@end
