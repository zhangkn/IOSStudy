//
//  NSString+Extension.m
//  HWeibo
//
//  Created by devzkn on 9/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


-(CGSize) sizeWithFont:(UIFont *)font{
    /** 方式一*/
    //    NSDictionary *tmpDict = @{NSFontAttributeName: font};
    //   return  [text sizeWithAttributes:tmpDict];
    /** 方式2*/
    //    CGFloat nameW = [statues.text sizeWithFont:HWNameLabelFont].width;
    /** 方式3*/
    return  [self sizeWithFont:font maxW:CGFLOAT_MAX];
}
-(CGSize) sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    NSDictionary *tmpDict = @{NSFontAttributeName: font};
    CGSize maxSize = CGSizeMake(maxW, CGFLOAT_MAX);
    return  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:tmpDict context:nil].size;
}

@end
