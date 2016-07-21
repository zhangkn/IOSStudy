//
//  HWTabBar.m
//  HWeibo
//
//  Created by devzkn on 7/21/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWTabBar.h"


@interface HWTabBar ()
/** ＋ 号按钮属性*/
@property (nonatomic,weak)UIButton *tabbarComposeButton;
@end
@implementation HWTabBar
@dynamic delegate;
//@dynamic 意思是由开发人员提供相应的代码：对于只读属性需要提供 setter，对于读写属性需要提供 setter 和 getter。
//@synthesize 意思是，除非开发人员已经做了，否则由编译器生成相应的代码，以满足属性声明。
/*
参数分为三类：
1）读写属性(readonly/readwrite)
2）setter语意（assign（默认的值，setter方法仅仅只是赋值，不释放旧址）/retain（释放旧址，赋值）/copy（在进行复制操作是和retain一样）

3）原子行（atomicity(原子的)/nonatomic（禁止多线程，变量保护））
 */

- (UIButton *)tabbarComposeButton{
    if (nil == _tabbarComposeButton) {
        //往tabBar 添加tabbarComposeButton
        UIButton *tmpView = [[UIButton alloc]init];
        [tmpView setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [tmpView setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [tmpView setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [tmpView setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        //设置大小
        tmpView.size= tmpView.currentBackgroundImage.size;
        [tmpView addTarget:self action:@selector(clickPlusButton:) forControlEvents:UIControlEventTouchUpInside];
        _tabbarComposeButton = tmpView;
        [self addSubview:_tabbarComposeButton];
    }
    return _tabbarComposeButton;
}

- (void)clickPlusButton:(UIButton*)tabbarComposeButton{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}
#pragma makr - 布局控件
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置＋号按钮的位置
    self.tabbarComposeButton.centerX = self.centerX;
    self.tabbarComposeButton.centerY= self.height*0.5;
    //设置其他按钮的位置、尺寸大小
    float childWidth =self.width/5;
    int otherChildButtonIndex = 0;//0,1,3,4//其他按钮的下标
    for (UIView *childView in self.subviews) {
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //设置宽、x
            childView.x= otherChildButtonIndex*childWidth;
            childView.width =childWidth;
            otherChildButtonIndex++;
            if (otherChildButtonIndex==2) {//保证otherChildButtonIndex 为0，1，3，4
                otherChildButtonIndex++;
            }
        }
    }
}


@end
