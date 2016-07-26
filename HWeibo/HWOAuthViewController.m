//
//  HWOAuthViewController.m
//  HWeibo
//
//  Created by devzkn on 7/26/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWOAuthViewController.h"

@implementation HWOAuthViewController

- (void)loadView{
    [super loadView];
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
}

@end
