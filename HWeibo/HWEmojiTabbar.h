//
//  HWEmojiTabbar.h
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWEmojiTabbarButtonTypeRecent = 1,
    HWEmojiTabbarButtonTypeDefault,
    HWEmojiTabbarButtonTypeEmoji ,
    HWEmojiTabbarButtonTypeHuaHua
} HWEmojiTabbarButtonType;

@class HWEmojiTabbar;
@protocol  HWEmojiTabbarDelegate  <NSObject>
@optional
- (void)emojiTabbar:(HWEmojiTabbar*)emojiTabbar didSelectedEmojiType:(HWEmojiTabbarButtonType)emojiTabbarButtonType;
@end

/** 表情键盘底部的选项卡*/
@interface HWEmojiTabbar : UIView
@property (nonatomic,assign) id<HWEmojiTabbarDelegate> delegate;




@end
