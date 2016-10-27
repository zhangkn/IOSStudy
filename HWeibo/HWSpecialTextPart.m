//
//  HWSpecialTextPart.m
//  HWeibo
//
//  Created by devzkn on 27/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "HWSpecialTextPart.h"

@implementation HWSpecialTextPart



+ (instancetype)specialTextPartWithText:(NSString *) text range:(NSRange)range{
    return [[self alloc]initWithText:text range:range ];
}

- (instancetype)initWithText:(NSString *)text range:(NSRange)range {
    HWSpecialTextPart *model = [[HWSpecialTextPart alloc]init];
    model.text = text;
    model.range = range;
    return model;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"text:%@ range%@",self.text,NSStringFromRange(self.range)];
}

@end
