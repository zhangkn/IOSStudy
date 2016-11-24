//
//  HLHtmlViewController.m
//  HisunLottery
//
//  Created by devzkn on 4/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLHtmlViewController.h"

@interface HLHtmlViewController ()<UIWebViewDelegate>

@end

@implementation HLHtmlViewController

- (void)loadView{
    UIWebView *webView =[[UIWebView alloc]init];
    [webView setDelegate:self];
    [self setView:webView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //设置取消按钮
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(btnCancel)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    //加载网页
    if (self.htmlModel.html.length) {
        [self loadRequestHtml];
    }
    
}
#pragma mark - UIWebViewDelegate 执行js 根据ID跳转到对应的标题
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (self.htmlModel.ID.length) {
        NSString *jsCode = [NSString stringWithFormat:@"window.location.href='#%@';",self.htmlModel.ID];
        [(UIWebView*)self.view stringByEvaluatingJavaScriptFromString:jsCode];
    }
}

#pragma mark - UIWebView 加载网页
- (void) loadRequestHtml{
    UIWebView *view = (UIWebView*)self.view;
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.htmlModel.html withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [view loadRequest:request];
}

- (void)btnCancel {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
