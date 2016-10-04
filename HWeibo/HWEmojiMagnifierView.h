//
//  HWEmojiMagnifierView.h
//  HWeibo
//
//  Created by devzkn on 03/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWEmotionModel.h"
#import "HWEmojiButton.h"
/** 表情放大镜*/
@interface HWEmojiMagnifierView : UIView


+ (instancetype) emojiMagnifierView;


/** 展示放大镜*/
- (void)showFormButton:(HWEmojiButton*)btn;

@end
