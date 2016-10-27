//
//  HWStatueTextView.m
//  HWeibo
//
//  Created by devzkn on 27/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "HWStatueTextView.h"
#import "HWStatusTextPartModel.h"

@interface HWStatueTextView ()

@end

@implementation HWStatueTextView




- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置自己的属性
        //设置不可编辑
        self.scrollEnabled = NO;
        self.textContainerInset = UIEdgeInsetsMake(0,-5, 0, -5);//去掉默认的文本间距,配合scrollEnabled=NO 一起使用,否则left、right不会生效
        self.editable = NO;
    }
    return self;
}
/** 处理点击特殊字符串*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.specialRannges.count==0) {
        return;
    }
//    NSLog(@"%@",(HWSpecialTextPart*)self.specialRannges.firstObject);
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];//选中的点在以当前视图的坐标系的x,y
    //    //判断接触的点是否在特殊字符串的范围rect之内  point isIn (text->range->)Rect
       //处理特殊字符串所在的范围
    if (![self isPointInHWSpecialTextPartRectWithpoint:point]) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
     [attributedText addAttribute:NSBackgroundColorAttributeName value:[UIColor grayColor] range:self.selectedRange];
    self.attributedText =attributedText;
}
/**  (text->range->)Rect*/
- (BOOL)isPointInHWSpecialTextPartRectWithpoint:(CGPoint)point{
    //遍历特殊字符串的rect
    for (HWSpecialTextPart *obj in self.specialRannges) {
        self.selectedRange = obj.range;
        UITextRange *textRange = [self selectedTextRange];
        NSArray *rects=  [self selectionRectsForRange:textRange];//根据文本的range，来确定rect; 返回值是数组，因为可能特殊字符串存在换行的情况
        for (UITextSelectionRect *obj in rects) {
            if (CGRectContainsPoint(obj.rect, point)) {
                return YES;
            }
        }
    }
    return NO;
}

/** 处理松开特殊字符串*/
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

@end
