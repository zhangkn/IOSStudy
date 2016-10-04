//
//  HWEmojiButton.h
//  HWeibo
//
//  Created by devzkn on 03/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWEmotionModel.h"
//@class HWEmojiButton;
//@protocol HWEmojiButtonDelegate <NSObject>
//@optional
//- (void)emojiButton:(HWEmojiButton*)btn  btnLongBegan:(UILongPressGestureRecognizer *)gestureRecognizer;
//
//- (void)emojiButton:(HWEmojiButton*)btn  btnLongEnd:(UILongPressGestureRecognizer *)gestureRecognizer;


//@end

@interface HWEmojiButton : UIButton

@property (nonatomic,strong) HWEmotionModel *emotionModel;//视图对应的模型，是视图提供给外界的接口

//@property (nonatomic,assign) id<HWEmojiButtonDelegate> delegate;


@end
