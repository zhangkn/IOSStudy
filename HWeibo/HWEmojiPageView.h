//
//  HWEmojiPageView.h
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HWEmojiListViewScrollViewMaxClos 7
#define HWEmojiListViewScrollViewMaxRows 3
#define HWEmojiListViewScrollViewMaxEmojiCout 20
#define HWEmojiListViewScrollViewMargin 10
/** 存放表情的控件*/
@interface HWEmojiPageView : UIView

@property (nonatomic,strong) NSArray *emotions;

@end
