//
//  HWEmojiButton.m
//  HWeibo
//
//  Created by devzkn on 03/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmojiButton.h"
#import "NSString+Emoji.h"

@interface HWEmojiButton ()

@end

@implementation HWEmojiButton

- (void)setEmotionModel:(HWEmotionModel *)emotionModel{
    _emotionModel = emotionModel;
    if ([emotionModel.type isEqualToString:@"0"]) {
        [self setImage:[UIImage imageNamed:emotionModel.png] forState:UIControlStateNormal];
    }else if([emotionModel.type isEqualToString:@"1"]){
        [self  setTitle:[emotionModel.code emoji]forState:UIControlStateNormal];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self setAdjustsImageWhenHighlighted:NO];
    //button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.1; //定义按的时间
    [self addGestureRecognizer:longPress];
}

-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(emojiButton:btnLongBegan:)]) {
            [self.delegate emojiButton:self btnLongBegan:gestureRecognizer];
        }
    }else if(UIGestureRecognizerStateEnded == [gestureRecognizer state]){
        if ([self.delegate respondsToSelector:@selector(emojiButton:btnLongEnd:)]) {
            [self.delegate emojiButton:self btnLongEnd:gestureRecognizer];
        }
    }
}


@end
