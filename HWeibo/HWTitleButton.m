//
//  HWTitleButton.m
//  HWeibo
//
//  Created by devzkn on 7/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWTitleButton.h"

@implementation HWTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.imageView.contentMode = UIViewContentModeCenter;
        UIImage *navigationbarArrowDown =[UIImage imageNamed:@"navigationbar_arrow_down"];
        UIImage *navigationbarArrowUp =[UIImage imageNamed:@"navigationbar_arrow_up"];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setImage:navigationbarArrowDown forState:UIControlStateNormal];
        [self setImage:navigationbarArrowUp forState:UIControlStateSelected];
        
    }
    return self;
}

/** 设置按钮内部image View 的frame*/
//- (CGRect)imageRectForContentRect:(CGRect)contentRect{
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
#pragma mark - 修改titleLabel、imageView位置
- (void)layoutSubviews{
    [super layoutSubviews];
    ////    设置边距,setImageEdgeInsets, titleEdgeInsets 适用于 文字和图片大下固定的场景
//    NSMutableDictionary *attributesDict = [NSMutableDictionary dictionary];
//    attributesDict[NSFontAttributeName] = self.titleLabel.font;
//    CGFloat titleW = [self.currentTitle sizeWithAttributes:attributesDict].width;
//    //    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0,imageW, 0, 0)];
    self.titleLabel.x= self.imageView.x;
    self.imageView.x= CGRectGetMaxX(self.titleLabel.frame);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
