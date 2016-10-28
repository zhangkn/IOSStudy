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

/** 存储正文的特殊字符串在attributedText的range数组   HWSpecialTextPart*/
@property (nonatomic,strong) NSMutableArray *specialRannges;
/* 当然亦可以采用以下方式进行数据传递
[attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
                                                             //获取数据
 NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
                                                            */

@end
