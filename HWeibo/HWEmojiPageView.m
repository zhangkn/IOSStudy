//
//  HWEmojiPageView.m
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmojiPageView.h"
#import "HWEmotionModel.h"

#import "NSString+Emoji.h"
#import "HWEmojiMagnifierView.h"

#import "HWEmojiButton.h"

@interface HWEmojiPageView ()<HWEmojiButtonDelegate>

@property (nonatomic,strong) HWEmojiMagnifierView *emojiMagnifierView;


@end

@implementation HWEmojiPageView


- (HWEmojiMagnifierView *)emojiMagnifierView{
    if (nil == _emojiMagnifierView) {
        HWEmojiMagnifierView *tmpView =[HWEmojiMagnifierView emojiMagnifierView];
        _emojiMagnifierView = tmpView;
    }
    return _emojiMagnifierView;
}
- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    //创建子控件
    [self setupbuttonWithEmotion:emotions];
  
}

- (void) setupbuttonWithEmotion:(NSArray*)emotions{
    
    NSLog(@"%ld",emotions.count);
    for (int i=0; i<emotions.count+1; i++) {
        HWEmojiButton *tmp = [[HWEmojiButton alloc]init];
        //设置表情
        if (i == emotions.count) {
            [tmp setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
            [tmp setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
            [self addSubview:tmp];
            return;
        }
        HWEmotionModel *model = emotions[i];
        tmp.emotionModel = model;
        tmp.titleLabel.font = [UIFont systemFontOfSize:32];
        //监听按钮事件：处理表情的放大、通知保存最近使用的表情
        [tmp addTarget:self action:@selector(clickEmojiButton:) forControlEvents:UIControlEventTouchUpInside];
        
        tmp.delegate = self;
        
        [self addSubview:tmp];
    }
    
}

#pragma mark  HWEmojiButtonDelegate -监听按钮事件：处理表情的放大
- (void)emojiButton:(HWEmojiButton *)btn btnLongBegan:(UILongPressGestureRecognizer *)gestureRecognizer{
    NSLog(@"长按事件");
    self.emojiMagnifierView.centerX = btn.centerX;
    self.emojiMagnifierView.y = btn.centerY - self.emojiMagnifierView.height;
    //坐标系转换,从 btn.superview 转换到 WINDOWLast
    self.emojiMagnifierView.frame = [btn.superview convertRect:self.emojiMagnifierView.frame toView:WINDOWLast];
    //设置放大镜数据
    self.emojiMagnifierView.emotionModel =btn.emotionModel;
    [WINDOWLast addSubview:self.emojiMagnifierView];
}
/** 与点击事件一样，将文字上送给textview 通知保存最近使用的表情*/
- (void)emojiButton:(HWEmojiButton *)btn btnLongEnd:(UILongPressGestureRecognizer *)gestureRecognizer{
    NSLog(@"长按事件  取消%@",btn.emotionModel.chs);

    [self processChooseEmojiEvent:btn];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.emojiMagnifierView removeFromSuperview];
    });
    
}





#pragma mark -监听按钮事件：/** 将文字上送给textview 通知保存最近使用的表情*/
- (void)clickEmojiButton:(HWEmojiButton*)btn{
    [self processChooseEmojiEvent:btn];
    
}
/** 将文字上送给textview 保存最近使用的表情 */
- (void)processChooseEmojiEvent:(HWEmojiButton*)btn{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[HWselectedEmojiModelKey]= btn.emotionModel;
    [[NSNotificationCenter defaultCenter]postNotificationName:HWdidSelectedEmojiNofificationName object:nil userInfo:userInfo];
    
}




- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat wh = (self.width-2*HWEmojiListViewScrollViewMargin)/HWEmojiListViewScrollViewMaxClos;
    CGFloat h = (self.height- HWEmojiListViewScrollViewMargin)/HWEmojiListViewScrollViewMaxRows;
    for (int i=0; i<self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:[HWEmojiMagnifierView class]]) {//self.subviews.count-1 放大镜
            return;//不计算放大镜的frame
        }
        HWEmojiButton *tmp = self.subviews[i];
        if ([self.subviews containsObject:self.emojiMagnifierView]) {
            if (i == self.subviews.count-2) {//删除按钮
                i = HWEmojiListViewScrollViewMaxEmojiCout;//删除按钮的位置比较特殊
            }
        }else{
            //没有emojiMagnifierView 的情况
            if (i == self.subviews.count-1) {//删除按钮
                i = HWEmojiListViewScrollViewMaxEmojiCout;//删除按钮的位置比较特殊
            }
        }
       //计算表情按钮的frame
        int row = i/HWEmojiListViewScrollViewMaxClos;
        int clo = i%HWEmojiListViewScrollViewMaxClos;
        tmp.x = clo*wh+HWEmojiListViewScrollViewMargin;
        tmp.y = row*wh+HWEmojiListViewScrollViewMargin;
        tmp.width = wh;
        tmp.height = h;
    }
    
    
    
}

@end
