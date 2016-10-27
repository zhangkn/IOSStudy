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

- (instancetype) initWithText:(NSString *) text range:(NSRange)range;
+ (instancetype) specialTextPartWithText:(NSString *) text range:(NSRange)range;


@end
