//
//  HWStatueTextView.h
//  HWeibo
//
//  Created by devzkn on 27/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWSpecialTextPart.h"
/** 用于展示微博的正文信息*/
@interface HWStatueTextView : UITextView

/** 存储正文的特殊字符串在attributedText的range数组*/
@property (nonatomic,strong) NSMutableArray *specialRannges;

@end
