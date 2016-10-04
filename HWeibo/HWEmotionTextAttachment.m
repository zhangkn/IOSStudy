//
//  HWEmotionTextAttachment.m
//  HWeibo
//
//  Created by devzkn on 04/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmotionTextAttachment.h"

@implementation HWEmotionTextAttachment
- (NSString *)getChs{
    return self.model.chs;
}

- (void)setModel:(HWEmotionModel *)model{
    _model = model;
    //设置image  属性
    self.image = [UIImage imageNamed:model.png];
}

- (instancetype)initWithEmotionModel:(HWEmotionModel *)model{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

+ (instancetype)initWithEmotionModel:(HWEmotionModel *)model{
    return [[self alloc]initWithEmotionModel:model];
}



@end
