//
//  HWNavigationController.m
//  HWeibo
//
//  Created by devzkn on 6/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWNavigationController.h"

@implementation HWNavigationController

#pragma mark - 拦截push;--//90%的拦截，都是通过自定义类，重写自带的方法实现
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed =YES;
        //设置左边按钮
        viewController.navigationItem.leftBarButtonItem =[UIBarButtonItem barButtonItemWithTarget:self  Image:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted" actionMethod:@selector(backAction)];
        //设置右边按钮
        viewController.navigationItem.rightBarButtonItem =[UIBarButtonItem barButtonItemWithTarget:self  Image:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" actionMethod:@selector(moreAction)];
    }
    [super pushViewController:viewController animated:animated];

}
- (void)backAction{
    [self popViewControllerAnimated:YES];
}
- (void)moreAction{
    [self popToRootViewControllerAnimated:YES];
}

@end
