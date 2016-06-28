//
//  HWTabBarController.m
//  HWeibo
//
//  Created by devzkn on 6/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWTabBarController.h"
#import "HWDiscoverTableViewController.h"
#import "HWMessageTableViewController.h"
#import "HWMeTableViewController.h"
#import "HWHomeTableViewController.h"
#import "HWNavigationController.h"
@interface HWTabBarController ()

@end

@implementation HWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化子控制器
    //设置子控制器
    UIViewController *home =[[HWHomeTableViewController alloc]init];
    [self addChildVC:home Title:@"Home" imageName:@"tabbar_home" selectwsImageName:@"tabbar_home_selected"];
    UIViewController *message =[[HWMessageTableViewController alloc]init];
    [self addChildVC:message Title:@"Message" imageName:@"tabbar_message_center" selectwsImageName:@"tabbar_message_center_selected"];
    UIViewController *discover = [[HWDiscoverTableViewController alloc]init];
    [self addChildVC:discover Title:@"Discover" imageName:@"tabbar_discover" selectwsImageName:@"tabbar_discover_selected"];
    UIViewController *me = [[HWMeTableViewController alloc]init];
    [self addChildVC:me Title:@"Me" imageName:@"tabbar_profile" selectwsImageName:@"tabbar_profile_selected"];
}

#pragma mark -     //设置子控制器
- (void)addChildVC:(UIViewController*)childVC Title:(NSString*)title imageName:(NSString*)imageName  selectwsImageName:(NSString*)selectwsImageName {
    childVC.view.backgroundColor = HWRandomColor;
//    vc1.tabBarItem.title = title;//设置tabBar 的文字
//    vc1.navigationItem.title = title;//设置导航栏的标题
    childVC.title = title;//同时设置tabBar 和导航栏的标题
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectwsImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//图片按照原样显示，不要自动渲染成其他颜色
    //设置文字样式
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    [childVC.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    //选择状态的文字颜色
    NSMutableDictionary *selectedTextAttr = [NSMutableDictionary dictionary];
    [selectedTextAttr setValue:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [childVC.tabBarItem setTitleTextAttributes:selectedTextAttr forState:UIControlStateSelected];
    HWNavigationController *navigationVC = [[HWNavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:navigationVC];
}


@end
