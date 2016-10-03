//
//  HWEmotionTextView.h
//  HWeibo
//
//  Created by devzkn on 03/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWPlaceholderTextView.h"
@class HWEmotionModel,HWEmotionTextView;
@protocol HWEmotionTextViewDelegate <NSObject>

@optional

- (BOOL)emotionTextView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

@interface HWEmotionTextView : HWPlaceholderTextView
/** 将表情添加到textView*/
- (void)insertEmotions:(HWEmotionModel*)model;

@property (nonatomic,assign) id<HWEmotionTextViewDelegate> emotionTextViewDelegate;

@end
