//
//  NSString+Extension.h
//  HWeibo
//
//  Created by devzkn on 9/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

-(CGSize) sizeWithTextFont:(UIFont *)font;
/** 根据字体和给定的最大宽度计算字符串的size*/
-(CGSize) sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
@end
