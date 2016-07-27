//
//  HWOAuthViewController.m
//  HWeibo
//
//  Created by devzkn on 7/26/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "AFNetworking.h"
#import "HWTabBarController.h"
#import "HWNewFeatureViewController.h"
#import "HWAccountModel.h"
#import "MBProgressHUD+MJ.h"
#define HWClientId @"647592779"
#define HWRedirectUri @"https://www.baidu.com"
#define HWClientSecret @"713f7438c3dc731b87d8a9624e7e8ab9"


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
    //请求管理器
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    [mgr setResponseSerializer:[AFJSONResponseSerializer serializer]];//afn 默认的解析器
    /** 可以修改源代码，来支持更多的ContentTypes
     self.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", nil];
*/
    //拼接请求参数
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"client_id"]=HWClientId;//申请应用时分配的AppKey。
    paramters[@"client_secret"]= HWClientSecret;//申请应用时分配的AppSecret。
    paramters[@"grant_type"]= @"authorization_code";//请求的类型，填写authorization_code
    paramters[@"code"]= code;//调用authorize获得的code值。
    paramters[@"redirect_uri"]= HWRedirectUri;//	回调地址，需需与注册应用里的回调地址一致。
    //发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:paramters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD hideHUD];
        /**
         {
         "access_token" = "2.00AnExMD0p9Oph67943a5a72L4R5WE";
         "expires_in" = 143397;
         "remind_in" = 143397;
         uid = 2939794294;
         }
         */
        NSLog(@"%@,%@",responseObject[@"access_token"],responseObject);//2.00tiObTG0p9Oph988048ce86X7FMbC,    uid = 5934185471;    "expires_in" = 157679999;
        NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];///Users/devzkn/Library/Developer/CoreSimulator/Devices/5A6E02FF-A156-455B-AE43-C207F4E7FBC4/data/Containers/Data/Application/62D2DAEF-5064-47A3-B04B-A7933DE6CA31/Documents
//        NSString *doc = [documentDirectory stringByAppendingPathComponent:@"account.plist"];
//        [responseObject writeToFile:doc atomically:YES];
        //自定义对象的存储
        NSString *doc = [documentDirectory stringByAppendingPathComponent:@"account.archive"];
        HWAccountModel *account = [HWAccountModel accountWithDictionary:responseObject];
        [NSKeyedArchiver archiveRootObject:account toFile:doc];
        //切换窗口的根控制器
        [self isShowNewFeatureViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

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
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}


@end
