//
//  AppDelegate.m
//  HWeibo
//
//  Created by devzkn on 6/13/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "AppDelegate.h"
#import "HWDiscoverTableViewController.h"
#import "HWMessageTableViewController.h"
#import "HWMeTableViewController.h"
#import "HWHomeTableViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [[UIScreen mainScreen]bounds];
    //设置根控制器
    UITabBarController *vc = [[UITabBarController alloc]init];
    self.window.rootViewController = vc;
    //设置子控制器
    UIViewController *vc1 =[[HWMeTableViewController alloc]init];
    [self addChildVC:vc1 Title:@"Home" imageName:@"tabbar_home" selectwsImageName:@"tabbar_home_selected"];
    UIViewController *vc2 =[[HWMessageTableViewController alloc]init];
    [self addChildVC:vc2 Title:@"Message" imageName:@"tabbar_message_center" selectwsImageName:@"tabbar_message_center_selected"];
    UIViewController *vc3 = [[HWDiscoverTableViewController alloc]init];
    [self addChildVC:vc3 Title:@"Discover" imageName:@"tabbar_discover" selectwsImageName:@"tabbar_discover_selected"];
    UIViewController *vc4 = [[HWMeTableViewController alloc]init];
    [self addChildVC:vc4 Title:@"Me" imageName:@"tabbar_profile" selectwsImageName:@"tabbar_profile_selected"];
    vc.viewControllers = @[vc1,vc2,vc3,vc4];
    
    //显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark -     //设置子控制器
- (void)addChildVC:(UIViewController*)vc1 Title:(NSString*)title imageName:(NSString*)imageName  selectwsImageName:(NSString*)selectwsImageName {
    vc1.view.backgroundColor = HWRandomColor;
    vc1.tabBarItem.title = title;
    vc1.tabBarItem.image = [UIImage imageNamed:imageName];
    vc1.tabBarItem.selectedImage = [[UIImage imageNamed:selectwsImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//图片按照原样显示，不要自动渲染成其他颜色
    //设置文字样式
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    [vc1.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    //选择状态的文字颜色
    NSMutableDictionary *selectedTextAttr = [NSMutableDictionary dictionary];
    [selectedTextAttr setValue:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [vc1.tabBarItem setTitleTextAttributes:selectedTextAttr forState:UIControlStateSelected];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
