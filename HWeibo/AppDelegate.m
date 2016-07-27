//
//  AppDelegate.m
//  HWeibo
//
//  Created by devzkn on 6/13/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "AppDelegate.h"
#import "HWTabBarController.h"
#import "HWNewFeatureViewController.h"
#import "HWOAuthViewController.h"
#import "HWAccountModel.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [[UIScreen mainScreen]bounds];
    //设置根控制器
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.archive"];
//    NSDictionary *accountDict = [NSDictionary dictionaryWithContentsOfFile:path];
    HWAccountModel *acount = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@",path);
    if (acount) {//已经存在用户信息
        [self isShowNewFeatureViewController];
    }else{
        self.window.rootViewController = [[HWOAuthViewController alloc]init];
    }
    //显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 判断是否显示新特性
- (void)isShowNewFeatureViewController{
    //获取当前版本号
    NSString *versionKey = @"CFBundleVersion";
    NSDictionary *infoDictionary=[NSBundle mainBundle].infoDictionary;
    NSString *infoPlistCFBundleVersion =infoDictionary[versionKey];
    //获取上次打开的版本号
    NSString *userDefaultsCFBundleVersion =[[NSUserDefaults standardUserDefaults] valueForKey:versionKey];
    NSLog(@"%@,%@",infoPlistCFBundleVersion,userDefaultsCFBundleVersion);
    UIViewController *vc;
    if (!userDefaultsCFBundleVersion || ![userDefaultsCFBundleVersion isEqualToString:infoPlistCFBundleVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:infoPlistCFBundleVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        vc = [[HWNewFeatureViewController alloc]init];
    }else{
        vc = [[HWTabBarController alloc]init];
    }
    self.window.rootViewController = vc;
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
