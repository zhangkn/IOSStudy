//
//  HWEmojiTabbarButton.m
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmojiTabbarButton.h"
#define HWEmojiTabbarSelctedColor HWColor(185, 185, 185)
#define HWEmojiTabbarNoSelctedColor  [UIColor whiteColor]
@implementation HWEmojiTabbarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:HWColor(70, 70, 70) forState:UIControlStateSelected];
        [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    //去掉高亮操作
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    //设置颜色
    if (selected) {
        self.backgroundColor = HWEmojiTabbarSelctedColor;
    }else{
        self.backgroundColor =HWEmojiTabbarNoSelctedColor;
    }
}


@end
