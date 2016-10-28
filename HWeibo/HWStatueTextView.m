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
/** 标识是否点击来特殊字符串*/
@property (nonatomic,assign)BOOL isTouchInSpecialRect;
/** 存储着特殊字符串的rect  字典数组 value ：rects ，key: HWSpecialTextPart.h*/
@property (nonatomic,strong)NSArray *rects;


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
#define HWtouchesSpecialStringColor [UIColor grayColor]
/** 处理点击特殊字符串*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self setupspecialRannges];
    if (self.specialRannges.count==0) {
        return;
    }
//    NSLog(@"%@",(HWSpecialTextPart*)self.specialRannges.firstObject);
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];//选中的点在以当前视图的坐标系的x,y
    //    //判断接触的点是否在特殊字符串的范围rect之内  point isIn (text->range->)Rect
    NSArray *rects = [self isPointInHWSpecialTextPartRectWithpoint:point].rects;
    if (!self.isTouchInSpecialRect) {
        return;
    }
    [self processTouchSpecialStringWithRects:rects];       //处理特殊字符串所在的范围
//    [self setNSMutableAttributedStringColorWithColor:HWtouchesSpecialStringColor];
}

#pragma mark - 处理点击事件的辅助方法
#define HWCoverTag 999
- (void)processTouchSpecialStringWithRects:(NSArray*)rects{
    for (NSValue *obj in rects) {
        CGRect rect = [obj CGRectValue];
        UIView *tmp = [[UIView alloc]init];
        tmp.backgroundColor =HWtouchesSpecialStringColor;
        tmp.frame = rect;
        tmp.layer.cornerRadius  = 3;
        tmp.alpha = 0.3;
        tmp.tag =HWCoverTag;
        [self addSubview:tmp];
    }
  
}

- (void)setNSMutableAttributedStringColorWithColor:(UIColor*)color{
    if (!color) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    [attributedText addAttribute:NSBackgroundColorAttributeName value:color range:self.selectedRange];
    self.attributedText =attributedText;
}

/**  (text->range->)Rect 判断用户点击的点，是否在特殊字符串的范围，如果在，就返回对应的模型对象textPart*/
- (HWSpecialTextPart*)isPointInHWSpecialTextPartRectWithpoint:(CGPoint)point{
    //遍历特殊字符串的rect
    [self setupspecialRannges];//及时更新range的rect 范围
    for (HWSpecialTextPart *textPart in self.specialRannges) {
        for (NSValue *obj in textPart.rects) {
            CGRect rect = [obj CGRectValue];
            if (CGRectContainsPoint(rect, point)) {
                self.isTouchInSpecialRect = YES;
                return textPart;
            }
        }
    }
    self.isTouchInSpecialRect = NO;
    return  nil;
}
/** HWSpecialTextPart->range_>rect*/
- (NSArray*)rectsForHWSpecialTextPartInHWStatueTextView:(HWSpecialTextPart*)textPart{
    self.selectedRange = textPart.range;
    UITextRange *textRange = [self selectedTextRange];
    NSArray *rects=  [self selectionRectsForRange:textRange];//根据文本的range，来确定rect; 返回值是数组，因为可能特殊字符串存在换行的情况
    self.selectedRange = NSMakeRange(0, 0);
    //过滤掉width == 0 ，height == 0
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    for (UITextSelectionRect *obj in rects) {
        if (obj.rect.size.width == 0 || obj.rect.size.height == 0) {
            continue;
        }
        [tmp addObject:[NSValue valueWithCGRect:obj.rect]];
    }
    return tmp;
}
- (void)setupspecialRannges{
    //由HWSpecialTextPart的range ->rects.  确保只计算一次rects
    for (HWSpecialTextPart *obj in self.specialRannges) {
        obj.rects = [self rectsForHWSpecialTextPartInHWStatueTextView:obj];
    }
}

//- (void)setSpecialRannges:(NSMutableArray *)specialRannges{
//    _specialRannges = specialRannges;
//    [self setupspecialRannges];
//}

/** 处理松开特殊字符串*/
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.specialRannges.count==0 || !self.isTouchInSpecialRect) {
        return;
    }
//    //取消设置的对应效果
//    [self setNSMutableAttributedStringColorWithColor:[UIColor clearColor]];
//    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    for (UIView *obj in self.subviews) {
//        if (obj.tag == HWCoverTag){
//            [obj removeFromSuperview];
//        }
//    }
    weakSelf(weakself);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself touchesCancelled:touches withEvent:event];
    });
  
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.specialRannges.count==0 || !self.isTouchInSpecialRect) {
        return;
    }
    for (UIView *obj in self.subviews) {
        if (obj.tag == HWCoverTag){
            [obj removeFromSuperview];
        }
    }
    
}

#pragma mark - 事件拦截的处理：去掉textView的copy功能  先调用 - (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event； 再调用- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
/** whether the receiver contains the specified point.*/
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //    //判断接触的点是否在特殊字符串的范围rect之内  point isIn (text->range->)Rect
//    return self.isTouchInSpecialRect;
//    NSLog(@"%@",NSStringFromCGPoint(point));
    if ( [self isPointInHWSpecialTextPartRectWithpoint:point]) {
        return YES;
    }else{
        return NO;
    }
}
/**Returns the farthest descendant of the receiver in the view hierarchy (including itself) that contains a specified point. */
#if 0
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.isTouchInSpecialRect) {
        return self;
    }
    return [self superview];
}
#endif


@end
