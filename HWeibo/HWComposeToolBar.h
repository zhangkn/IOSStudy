//
//  HWComposeToolBar.h
//  HWeibo
//
//  Created by devzkn on 9/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 
  按钮的类型
 */
typedef enum{
    /**camerabutton  拍照*/
    HWComposeToolBarButtonTypeComposeCamerabutton = 1,
    /** compose_emoticonbutton 表情*/
    HWComposeToolBarButtonTypeComposeEmoticonbutton,
    /** 键盘类型*/
    HWComposeToolBarButtonTypeComposeKeyboardbutton,
    /**@ 提醒某人按钮 */
    HWComposeToolBarButtonTypeComposeMentionbutton,
    /** 相册*/
    HWComposeToolBarButtonTypeComposeToolbarPictureButton,
    /** 话题*/
    HWComposeToolBarButtonTypeComposeTrendbutton
} HWComposeToolBarButtonType;

/** 用于发送微博控制器的工具条*/
@class HWComposeToolBar;
@protocol HWComposeToolBarDelegete <NSObject>

@optional
- (void)composeToolBarDelegeteDidClickToolButton:(HWComposeToolBar*)composeToolBar clickToolButtonType:(HWComposeToolBarButtonType)clickToolButtonType;

@end

@interface HWComposeToolBar : UIView

@property (nonatomic,assign) id<HWComposeToolBarDelegete> delegete;



@end
