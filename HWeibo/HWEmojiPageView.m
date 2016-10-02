//
//  HWEmojiPageView.m
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmojiPageView.h"
#import "HWEmotionModel.h"

@implementation HWEmojiPageView

- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    //创建子控件
    [self setupbuttonWithEmotion:emotions];
    
}

- (void) setupbuttonWithEmotion:(NSArray*)emotions{
    
    NSLog(@"%ld",emotions.count);
    for (int i=0; i<emotions.count+1; i++) {
        UIButton *tmp = [[UIButton alloc]init];
        if (i == emotions.count) {
            [tmp setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
            [tmp setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
            [self addSubview:tmp];
            return;
        }
        HWEmotionModel *model = emotions[i];
        if ([model.type isEqualToString: @"0"]) {
            [tmp setImage:[UIImage imageNamed:model.png] forState:UIControlStateNormal];
        }
        [self addSubview:tmp];
    }
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat wh = (self.width-2*HWEmojiListViewScrollViewMargin)/HWEmojiListViewScrollViewMaxClos;
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *tmp = self.subviews[i];

        if (i == self.subviews.count-1) {
            i = HWEmojiListViewScrollViewMaxEmojiCout;
        }
        int row = i/HWEmojiListViewScrollViewMaxClos;
        int clo = i%HWEmojiListViewScrollViewMaxClos;
        tmp.x = clo*wh +HWEmojiListViewScrollViewMargin;
        tmp.y = row*wh;
        tmp.width = wh;
        tmp.height = wh;
    }
    
}

@end
