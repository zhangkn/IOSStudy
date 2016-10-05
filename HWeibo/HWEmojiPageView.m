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

@interface HWEmojiPageView ()<UIGestureRecognizerDelegate>

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

- (void)setupDeleteButton{
    UIButton *tmp = [[UIButton alloc]init];
    [tmp setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [tmp setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    [tmp addTarget:self action:@selector(clickDeleteEmojiButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tmp];
}

- (void) setupbuttonWithEmotion:(NSArray*)emotions{
    
//    NSLog(@"%ld",emotions.count);
//    if (emotions.count == 0) {
//        [self setupDeleteButton];
//        return;
//    }
    
    for (int i=0; i<emotions.count+1; i++) {
        //设置表情
        if (i == emotions.count) {
            [self setupDeleteButton];           
            return;
        }
        HWEmojiButton *tmp = [[HWEmojiButton alloc]init];
        HWEmotionModel *model = emotions[i];
        tmp.emotionModel = model;
        tmp.titleLabel.font = [UIFont systemFontOfSize:32];
        //监听按钮事件：处理表情的放大、通知保存最近使用的表情
        [tmp addTarget:self action:@selector(clickEmojiButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:tmp];
    }
    
}

- (void)clickDeleteEmojiButton:(UIButton*)btn{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//    userInfo[HWselectedEmojiModelKey]= btn.emotionModel;
    [[NSNotificationCenter defaultCenter]postNotificationName:HWdidClickDeleteEmojiButtonNofificationName object:nil userInfo:userInfo];

    
}


#pragma mark  HWEmojiButtonDelegate -监听按钮事件：处理表情的放大
- (void)emojiButton:(HWEmojiButton *)btn btnLongBegan:(UILongPressGestureRecognizer *)gestureRecognizer{
    [self.emojiMagnifierView showFormButton:btn];
  }
/** 与点击事件一样，将文字上送给textview 通知保存最近使用的表情*/
- (void)emojiButton:(HWEmojiButton *)btn btnLongEnd:(UILongPressGestureRecognizer *)gestureRecognizer{
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
    //保存最近使用的表情
    [HWEmojiKeyboardEmojiTool saveEmotionModel:btn.emotionModel];
}




- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat wh = (self.width-2*HWEmojiListViewScrollViewMargin)/HWEmojiListViewScrollViewMaxClos;
    CGFloat h = (self.height- HWEmojiListViewScrollViewMargin)/HWEmojiListViewScrollViewMaxRows;
    for (int i=0; i<self.subviews.count; i++) {        
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


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //button长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
//        longPress.minimumPressDuration = 0.1; //定义按的时间
        [self addGestureRecognizer:longPress];
        longPress.delegate = self;
    }
    return self;
}


-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
//            结束长按             //获取最终结束的位置
            weakSelf(weakSelf);
            [self processGestureRecognizerState:gestureRecognizer successFindBtnWithPointBlock:^(HWEmojiButton *btn, UILongPressGestureRecognizer *gestureRecognizer) {
                [weakSelf emojiButton:btn btnLongEnd:gestureRecognizer];//取消放大镜的同时，将表情添加到textview
            }];
            
        }
            break;
            
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            weakSelf(weakSelf);
            [self processGestureRecognizerState:gestureRecognizer successFindBtnWithPointBlock:^(HWEmojiButton *btn, UILongPressGestureRecognizer *gestureRecognizer) {
                [weakSelf emojiButton:btn btnLongBegan:gestureRecognizer];//            //只需要展示放大镜子

            }];
            
        }
            break;
            
            
        default:
            break;
    }
}
/** 成功找到手势对应的按钮，立即执行successFindBtnWithPointBlock*/
- (void)processGestureRecognizerState:(UILongPressGestureRecognizer*)gestureRecognizer successFindBtnWithPointBlock:(void(^)(HWEmojiButton* btn ,UILongPressGestureRecognizer* gestureRecognizer))successFindBtnWithPointBlock{
    // 获取对应的子空间按钮
    CGPoint point = [gestureRecognizer locationInView:self];
    HWEmojiButton *btn = [self btnWithPoint:point];
    if (btn) {//找到对应的表情按钮，根据state进行处理
        if (successFindBtnWithPointBlock) {
            successFindBtnWithPointBlock(btn,gestureRecognizer);
        }
    }else{//手势没有对应表情按钮
        NSLog(@"%s",__func__);
        //取消放大镜
        [self.emojiMagnifierView removeFromSuperview];
    }
}


- (HWEmojiButton *)btnWithPoint:(CGPoint)point{
    for (UIView *obj in self.subviews) {
        if (![obj isKindOfClass:[HWEmojiButton class]]) {
            return nil;
        }
        if (CGRectContainsPoint(obj.frame, point)) {
            return (HWEmojiButton*)obj;
        }
    }
    return nil;
}


@end
