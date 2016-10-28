//
//  HWSpecialTextPart.h
//  HWeibo
//
//  Created by devzkn on 27/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWSpecialTextPart : NSObject

@property (nonatomic,copy) NSString *text;
/** 存储的是特殊字符串在attributedText的range，用于对特殊字符串的事件监听处理*/
@property (nonatomic,assign) NSRange range;
/** 由range属性确定的rects      NSArray *rects=  [self selectionRectsForRange:textRange];//根据文本的range，来确定rect; 返回值是数组，因为可能特殊字符串存在换行的情况
 */
@property (nonatomic,strong) NSArray *rects;



- (instancetype) initWithText:(NSString *) text range:(NSRange)range;
+ (instancetype) specialTextPartWithText:(NSString *) text range:(NSRange)range;


@end
