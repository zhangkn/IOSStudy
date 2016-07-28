//
//  UIWindow+Extension.m
//  HWeibo
//
//  Created by devzkn on 7/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HWTabBarController.h"
#import "HWNewFeatureViewController.h"



@implementation UIWindow (Extension)

-(void)switchRootViewController{
    //获取当前版本号
    NSString *versionKey = @"CFBundleVersion";
    NSDictionary *infoDictionary=[NSBundle mainBundle].infoDictionary;
    NSString *infoPlistCFBundleVersion =infoDictionary[versionKey];
    //获取上次打开的版本号
    NSString *userDefaultsCFBundleVersion =[[NSUserDefaults standardUserDefaults] valueForKey:versionKey];
    UIViewController *vc;
    //确定是否显示新特性
    if (!userDefaultsCFBundleVersion || ![userDefaultsCFBundleVersion isEqualToString:infoPlistCFBundleVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:infoPlistCFBundleVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        vc = [[HWNewFeatureViewController alloc]init];
    }else{
        vc = [[HWTabBarController alloc]init];
    }
   self.rootViewController = vc;
}

@end
