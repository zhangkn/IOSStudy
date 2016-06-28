//
//  UIBarButtonItem+Extension.m
//  HWeibo
//
//  Created by devzkn on 6/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem*)barButtonItemWithTarget:(id)target Image:(NSString*)imageName highlightedImage:(NSString*)highlightedImage actionMethod:(SEL)actionMethod{
    // 设置图片
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    //设置frame
    button.size = button.currentBackgroundImage.size;
    //设置监听
    [button addTarget:target action:actionMethod forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
