//
//  HWClearCacheView.m
//  HWeibo
//
//  Created by devzkn on 24/11/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "HWClearCacheView.h"
#import "HWClearCacheTool.h"

@interface HWClearCacheView()
@property (weak, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;


@end

@implementation HWClearCacheView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (IBAction)close:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.y = self.height;
    }completion:^(BOOL finished) {
        self.y = 0;
        [self removeFromSuperview];
    }];


    
}

/** 清理缓存*/
- (IBAction)clickconfirmBtn:(UIButton *)sender {
    [self close:nil];
    //通知控制器处理缓存数据
    if ([self.delegate respondsToSelector:@selector(clearCacheViewDidClickConfirmButon:)]) {
        [self.delegate clearCacheViewDidClickConfirmButon:self];
    }
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    //设置按钮的边界颜色
    [self.confirmBtn.layer setBorderWidth:1];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){230.0/255.0,230.0/255.0,230.0/255.0,1});
    [self.confirmBtn.layer setBorderColor:color];
    [self.cancelBtn.layer setBorderWidth:1];
    [self.cancelBtn.layer setBorderColor:color];
    //在设置父视图的时候，只对父视图的透明度进行更改，而不影响它上面子视图的透明度。
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.view.layer.cornerRadius = 3;
    self.view.alpha =1;
//    self.view.userInteractionEnabled = NO;
    self.frame = [UIScreen mainScreen].bounds;

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
  if (CGRectContainsPoint(self.view.frame, point)) {
        return ;
    }
    [self close:nil];
}



-(void)willMoveToSuperview:(UIView *)newSuperview{
    self.view.y = self.view.height;
  [UIView  animateWithDuration:0.5 animations:^{
      self.view.y = 0;
  } completion:^(BOOL finished) {
      
  }];
}

#pragma mark - 事件拦截的处理：去掉textView的copy功能  先调用 - (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event； 再调用- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
/** whether the receiver contains the specified point.*/
#if 0
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //    //判断接触的点是否在特殊字符串的范围rect之内  point isIn (text->range->)Rect
    //    return self.isTouchInSpecialRect;
    //    NSLog(@"%@",NSStringFromCGPoint(point));
    return YES;
}
#endif
/**Returns the farthest descendant of the receiver in the view hierarchy (including itself) that contains a specified point. */
#if 0
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //坐标系转换
    CGRect cancelBtnFrame = [self.view convertRect:self.cancelBtn.frame toView:self];
    CGRect confirmBtnFrame = [self.view convertRect:self.confirmBtn.frame toView:self];

    if (CGRectContainsPoint(cancelBtnFrame, point) || (CGRectContainsPoint(confirmBtnFrame, point))) {
        return self;
    }

    return self;
}
#endif


@end
