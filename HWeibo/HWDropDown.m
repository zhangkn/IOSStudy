//
//  HWDropDown.m
//  HWeibo
//下拉菜单
//  Created by devzkn on 7/20/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWDropDown.h"

@interface HWDropDown ()
@property (nonatomic,weak) UIImageView *containerView;//用于存放下拉菜单控件

@end



@implementation HWDropDown

- (UIImageView *)containerView{
    if (nil == _containerView) {
        UIImageView *tmpView = [[UIImageView alloc]init];
        tmpView.userInteractionEnabled =YES;//开启用户交互功能
        [tmpView setImage:[UIImage imageNamed:@"popover_background"]];
        //将view添加到当前屏幕最上面的窗口
        [self addSubview:tmpView];//self.view.window=[UIApplication sharedApplication].keyWindow
        _containerView = tmpView;
        [self addSubview:_containerView];
    }
    return _containerView;
}
#pragma mark - 添加下拉框控件，并设置下拉框容器的尺寸
- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    //设置间距
    _contentView.y = 15;
    _contentView.x=10;
    //设置容器的尺寸，由contentView决定
    [self.containerView addSubview:contentView];
    self.containerView.height = contentView.y+CGRectGetMaxY(contentView.frame);
    self.containerView.width = contentView.x*2+contentView.width;

}

- (void)setContentViewController:(UIViewController *)contentViewController{
    _contentViewController = contentViewController;
    self.contentView = contentViewController.view;
}

#pragma mark - 设置下拉框容器的位置，并显示下拉框
- (void)showFrom:(UIView *)view{
    UIWindow *lastWindow =[[UIApplication sharedApplication].windows lastObject];
    [lastWindow addSubview:self];
    self.frame = lastWindow.bounds;
    //默认情况下，frame是以父控件的左上角为坐标原点
    CGRect fromViewRect = [view convertRect:view.bounds toView:lastWindow];
    self.containerView.y= CGRectGetMaxY(fromViewRect);
    self.containerView.centerX = CGRectGetMidX(fromViewRect);
    
    if ([self.delegate respondsToSelector:@selector(dropDownShow:)]) {
        [self.delegate dropDownShow:self];
    }


}
+(instancetype)nemu{
    return [[self alloc]init];
}
-(void)dismiss{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropDownDismiss:)]) {
        [self.delegate dropDownDismiss:self];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加蒙板
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

@end
