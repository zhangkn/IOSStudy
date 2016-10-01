//
//  HWComposeToolBar.m
//  HWeibo
//
//  Created by devzkn on 9/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWComposeToolBar.h"

@interface HWComposeToolBar ()

/** 
 
 */
/** 拍照按钮*/
@property (nonatomic ,weak) UIButton* composeCamerabutton;
/** 表情按钮*/
@property (nonatomic ,weak) UIButton* composeEmoticonbutton;
/** 键盘按钮*/
@property (nonatomic ,weak) UIButton* composeKeyboardbutton;
/** @按钮*/
@property (nonatomic ,weak) UIButton* composeMentionbutton;
/** 相册按钮*/
@property (nonatomic ,weak) UIButton* composeToolbarPictureButton;
/** #按钮 ,话题*/
@property (nonatomic ,weak) UIButton* composeTrendbutton;


@end



@implementation HWComposeToolBar

- (UIButton *)composeEmoticonbutton{
    if (nil == _composeEmoticonbutton) {
        UIButton *tmp = [self setupBUttonWithImage: @"compose_emoticonbutton_background" highlightedImageName:@"compose_emoticonbutton_background_highlighted"];
        _composeEmoticonbutton = tmp;
        tmp.tag = HWComposeToolBarButtonTypeComposeEmoticonbutton;
        [self addSubview:_composeEmoticonbutton];
    }
    return _composeEmoticonbutton;
}
- (UIButton *)composeKeyboardbutton{
    if (nil == _composeKeyboardbutton) {
        UIButton* tmp = [self setupBUttonWithImage: @"compose_keyboardbutton_background" highlightedImageName:@"compose_keyboardbutton_background_highlighted"];
        _composeKeyboardbutton = tmp;
        tmp.tag = HWComposeToolBarButtonTypeComposeKeyboardbutton;
        [self addSubview:_composeKeyboardbutton];
    }
    return _composeKeyboardbutton;
}
- (UIButton *)composeMentionbutton{
    if (nil == _composeMentionbutton) {
        UIButton *tmp = [self setupBUttonWithImage: @"compose_mentionbutton_background" highlightedImageName:@"compose_mentionbutton_background_highlighted"];
        _composeMentionbutton = tmp;
        tmp.tag = HWComposeToolBarButtonTypeComposeMentionbutton;
        [self addSubview:_composeMentionbutton];
    }
    return _composeMentionbutton;
}
- (UIButton *)composeCamerabutton{
    if (nil == _composeCamerabutton) {
        UIButton *tmp = [self setupBUttonWithImage: @"compose_camerabutton_background" highlightedImageName:@"compose_camerabutton_background_highlighted"];
        _composeCamerabutton = tmp;
        tmp.tag = HWComposeToolBarButtonTypeComposeCamerabutton;
        [self addSubview:_composeCamerabutton];
    }
    return _composeCamerabutton;
}
- (UIButton *)composeToolbarPictureButton{
    if (nil == _composeToolbarPictureButton) {
        UIButton *tmp = [self setupBUttonWithImage: @"compose_toolbar_picture" highlightedImageName:@"compose_toolbar_picture_highlighted"];
        _composeToolbarPictureButton = tmp;
        tmp.tag = HWComposeToolBarButtonTypeComposeToolbarPictureButton;
        [self addSubview:_composeToolbarPictureButton];
    }
    return _composeToolbarPictureButton;
}

- (UIButton *)composeTrendbutton{
    if (nil == _composeTrendbutton) {
        UIButton *tmp = [self setupBUttonWithImage: @"compose_trendbutton_background" highlightedImageName:@"compose_trendbutton_background_highlighted"];
        _composeTrendbutton = tmp;
        tmp.tag = HWComposeToolBarButtonTypeComposeTrendbutton;
        [self addSubview:_composeTrendbutton];
    }
    return _composeTrendbutton;
}

- (UIButton*) setupBUttonWithImage:(NSString*)imageName highlightedImageName:(NSString*)highlightedImageName{
    UIButton *tmpView = [[UIButton alloc]init];
    [tmpView setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tmpView setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [tmpView addTarget:self action:@selector(didclickButton:) forControlEvents:UIControlEventTouchUpInside];
    return tmpView ;

}
/** 以及界面切换*/
- (UIButton*)didclickButton:(UIButton*)btn{
    //表情视图和键盘视图的切换
    if (btn.tag == HWComposeToolBarButtonTypeComposeEmoticonbutton || btn.tag == HWComposeToolBarButtonTypeComposeKeyboardbutton) {
        self.composeEmoticonbutton.hidden = self.composeKeyboardbutton.hidden;
        self.composeKeyboardbutton.hidden = !self.composeEmoticonbutton.hidden;
    }
    
    // 通知控制器 界面切换
    if ([self.delegete respondsToSelector:@selector(composeToolBarDelegeteDidClickToolButton:clickToolButtonType:)]) {
        [self.delegete composeToolBarDelegeteDidClickToolButton:self clickToolButtonType:btn.tag];
    }
    
    return btn;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置自己的属性
        //创建子控件
        self.composeCamerabutton.hidden = NO;
        self.composeToolbarPictureButton.hidden = NO;
        self.composeMentionbutton.hidden = NO;
        self.composeTrendbutton.hidden = NO;
        self.composeEmoticonbutton.hidden = NO;
        self.composeKeyboardbutton.hidden = !self.composeEmoticonbutton.hidden;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    /** 计算子控件的frame*/
    CGFloat w = self.width/(self.subviews.count-1);
    CGFloat h = self.height;
    for (int i = 0 ; i < self.subviews.count-1; i++) {
         UIButton *tmp = nil;
        if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
            tmp = (UIButton*)self.subviews[i];
        }else{
            break;
        }
        tmp.width = w;
        tmp.height = h;
        tmp.x = i*w;
        tmp.y = 0;
    }
    self.composeKeyboardbutton.frame = self.composeEmoticonbutton.frame;
    
}


@end
