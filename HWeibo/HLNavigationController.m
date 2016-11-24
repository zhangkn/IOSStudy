//
//  HLNavigationController.m
//  HisunLottery
//
//  Created by devzkn on 4/25/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLNavigationController.h"

@interface HLNavigationController ()

@end

@implementation HLNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (void) setttingAppearance{
   //设置全局导航条外观
    [self settingUINavigationBarAppearance];
    if (IOS7) {
        return;//不需要设置全局导航条按钮主题
    }
    //设置全局导航条按钮主题
    [self settingbarButtonItenAppearance];
}

+ (void) settingUINavigationBarAppearance{
    /*
     @protocol UIAppearance <NSObject>  协议的代理方法+ (instancetype)appearance;
     
     @interface UIView : UIResponder < UIAppearance>
     */
    //方式一：获取全局外观
//    UINavigationBar *navigationBar =[UINavigationBar appearance];//获取所有导航条外观
    //方式二：获取我们自己导航控制器的导航条－－ 确保系统的其它功能（短信）的导航条与自己的冲突，尤其在短信分享这方面要注意
    UINavigationBar *navigationBar;
    if (IOS9) {
        //9.0的API
        navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[HLNavigationController class]]];
    }else{
        navigationBar = [UINavigationBar appearanceWhenContainedIn:[HLNavigationController class],nil];
    }
    
    /**
     导航栏背景的出图规格
     iOS6导航栏背景的出图规格
     非retina：320x44 px
     retina：640x88 px
     iOS7导航栏背景的出图规格
     retina：640x128 px
     */
    if (IOS7) {//2016-04-25 15:38:43.112 HisunLottery[4141:217528] 9.2
        
        [navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
        
    }else{
        [navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar"] forBarMetrics:UIBarMetricsDefault];
        
    }
    
    /*2.
     ＊标题：@property(nonatomic,copy) NSDictionary *titleTextAttributes;// 字典中能用到的key在UIStringDrawing.h中// 最新版本的key在UIKit框架的NSAttributedString.h中
     
     */
    //    NSDictionary *dict = @{UITextAttributeTextColor:[UIColor whiteColor]};
    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [navigationBar setTitleTextAttributes:dict];
    //2、The tint color to apply to the navigation items and bar button items. 导航条的主题颜色
    [navigationBar setTintColor:[UIColor whiteColor]];

    
}

+ (void) settingbarButtonItenAppearance{
        /**
     NS_CLASS_AVAILABLE_IOS(2_0) @interface UIBarItem : NSObject <NSCoding, UIAppearance>
     */
    //导航栏按钮主题
    UIBarButtonItem *barButtonIten = [UIBarButtonItem appearance];
    /*
     设置主题的方法：
     背景：- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;
     文字：- (void)setTitleTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state;
     导航栏返回按钮背景：- (void)setBackButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;
     */
    [barButtonIten setTintColor:[UIColor whiteColor]];
    
    [barButtonIten setBackgroundImage:[UIImage imageNamed:@"NavButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButtonIten setBackgroundImage:[UIImage imageNamed:@"NavButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [barButtonIten setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButtonIten setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}


#pragma mark - 重写pushViewController: animated:
/**
 1）自定义导航控制器的价值
 重写push方法就可以拦截所有压入栈中的子控制器，统一做一些处理
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [viewController setHidesBottomBarWhenPushed:YES];
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 设置一次性属性
/**
 1、ninitailize、load方法的区别：
 initailize、load都是类方法
 当一个类被装载进内存时，就会调用一次load方法（当时这个类还不可用）
 当第一次使用这个类,或者这个类的子类的时候，就会调用一次initailize方法
 2.+ (void)initialize
 Initializes the class before it receives its first message.
 */

+ (void)initialize{
    if (self == [HLNavigationController class]) {//保证只调用一次
        // ... do the initialization ...
        //设置导航条主题
        [self setttingAppearance];

    }
}

@end
