//
//  HWPlaceholderTextView.h
//  HWeibo
//
//  Created by devzkn on 9/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HWTextViewFont  [UIFont systemFontOfSize:13]

@interface HWPlaceholderTextView : UITextView
/** 占位符内容*/
@property (nonatomic,copy) NSString *textViewPalceHolder;
/** 占位符的颜色*/
@property (nonatomic,strong) UIColor *textViewPalceHolderColor;

@property (nonatomic,assign) BOOL hiddentextViewPalceHolder;

+ (instancetype) placeholderTextView;
/**
 通过数据模型设置视图内容，可以让视图控制器不需要了解视图的细节
 */
+ (instancetype) placeholderTextViewWithTextViewPalceHolder:(NSString *) textViewPalceHolder;







@end
