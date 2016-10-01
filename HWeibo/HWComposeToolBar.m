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
 compose_camerabutton_background_highlighted@2x   compose_camerabutton_background@2x
 compose_emoticonbutton_background_highlighted@2x
 compose_keyboardbutton_background_highlighted@2x
 compose_mentionbutton_background_highlighted@2x
 compose_toolbar_picture_highlighted@2x
 compose_trendbutton_background_highlighted@2x
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
        [self addSubview:_composeEmoticonbutton];
    }
    return _composeEmoticonbutton;
}
- (UIButton *)composeKeyboardbutton{
    if (nil == _composeKeyboardbutton) {
        UIButton* tmp = [self setupBUttonWithImage: @"compose_keyboardbutton_background" highlightedImageName:@"compose_keyboardbutton_background_highlighted"];
        _composeKeyboardbutton = tmp;
        [self addSubview:_composeKeyboardbutton];
    }
    return _composeKeyboardbutton;
}
- (UIButton *)composeMentionbutton{
    if (nil == _composeMentionbutton) {
        UIButton *tmp = [self setupBUttonWithImage: @"compose_mentionbutton_background" highlightedImageName:@"compose_mentionbutton_background_highlighted"];
        _composeMentionbutton = tmp;
        [self addSubview:_composeMentionbutton];
    }
    return _composeMentionbutton;
}
- (UIButton *)composeCamerabutton{
    if (nil == _composeCamerabutton) {
        UIButton *tmp = [self setupBUttonWithImage: @"compose_camerabutton_background" highlightedImageName:@"compose_camerabutton_background_highlighted"];
        _composeCamerabutton = tmp;
        [self addSubview:_composeCamerabutton];
    }
    return _composeCamerabutton;
}
- (UIButton *)composeToolbarPictureButton{
    if (nil == _composeToolbarPictureButton) {
        UIButton *tmp = [self setupBUttonWithImage: @"compose_toolbar_picture" highlightedImageName:@"compose_toolbar_picture_highlighted"];
        _composeToolbarPictureButton = tmp;
        [self addSubview:_composeToolbarPictureButton];
    }
    return _composeToolbarPictureButton;
}

- (UIButton *)composeTrendbutton{
    if (nil == _composeTrendbutton) {
        UIButton *tmp = [self setupBUttonWithImage: @"compose_trendbutton_background" highlightedImageName:@"compose_trendbutton_background_highlighted"];
        _composeTrendbutton = tmp;
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
    //界面切换
    if (btn == self.composeEmoticonbutton || btn == self.composeKeyboardbutton) {
        self.composeEmoticonbutton.hidden = self.composeKeyboardbutton.hidden;
        self.composeKeyboardbutton.hidden = !self.composeEmoticonbutton.hidden;
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
