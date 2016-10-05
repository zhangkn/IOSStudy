//
//  HWOAuthViewController.m
//  HWeibo
//
//  Created by devzkn on 7/26/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "AFNetworking.h"
#import "HWAccountModel.h"
#import "MBProgressHUD+MJ.h"
#import "HWAccountTool.h"



@interface HWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation HWOAuthViewController

- (void)loadView{
    [super loadView];
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate =self;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    //使用webView 加载Sina的登陆页面
    //请求参数/**    client_id:	申请应用时分配的AppKey。
//    redirect_uri:	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。*/
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",HWClientId,HWRedirectUri];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [webView loadRequest:request];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"loading"];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //拦截回调地址URL，获取用户授权的code
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length!=0) {//是回调地址
        //截取code＝ 后面的参数
        NSString *code = [url substringFromIndex:(range.location+range.length)];
        [self getAccessTokenWithCode:code];
        return NO;
    }
    return YES;
}
#pragma mark - 获取access_token:一个用户给一个应用授权，就会获取到一个access_token
- (void)getAccessTokenWithCode:(NSString*)code{
    //拼接请求参数
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"client_id"]=HWClientId;//申请应用时分配的AppKey。
    paramters[@"client_secret"]= HWClientSecret;//申请应用时分配的AppSecret。
    paramters[@"grant_type"]= @"authorization_code";//请求的类型，填写authorization_code
    paramters[@"code"]= code;//调用authorize获得的code值。
    paramters[@"redirect_uri"]= HWRedirectUri;//	回调地址，需需与注册应用里的回调地址一致。
    NSString *strUrl = @"https://api.weibo.com/oauth2/access_token";
    //发送请求
    [HWHttpTool POST:strUrl parameters:paramters success:^(id responseObject) {
        HWAccountModel *account = [HWAccountModel accountWithDictionary:responseObject];
        //存储帐号信息
        [HWAccountTool saveAccount:account];
        //切换窗口的根控制器
        [[UIApplication sharedApplication].keyWindow switchRootViewController];
    } failure:^(NSError *error) {
        
    }];
}


@end
