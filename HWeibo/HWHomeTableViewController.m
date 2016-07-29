//
//  HWHomeTableViewController.m
//  HWeibo
//
//  Created by devzkn on 6/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWHomeTableViewController.h"
#import "HWDropDown.h"
#import "AFNetworking.h"
#import "HWAccountTool.h"
#import "HWTitleButton.h"

@interface HWHomeTableViewController ()<HWDropDownDelagate>

@end

@implementation HWHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setNavigationContent];
    //获取用户信息
    [self getUserInfo];
}
#pragma mark -  获取用户信息
/** 

 */
- (void) getUserInfo{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    HWAccountModel *account = [HWAccountTool account];
    parameters[@"access_token"]= account.access_token;
    parameters[@"uid"]= account.uid;
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //设置首页标题文字
        NSLog(@"%@",responseObject);
        UIButton *titleButton = (UIButton*)self.navigationItem.titleView;
        account.name = responseObject[@"name"];
        [titleButton setTitle:account.name forState:UIControlStateNormal];
        //存储昵称
        [HWAccountTool  saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"%@",error);
    }];
}

#pragma mark - 设置导航栏器内容
- (void) setNavigationContent{
    //设置左边按钮
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem barButtonItemWithTarget:self  Image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted" actionMethod:@selector(friendsearch)];
    //设置右边按钮
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem barButtonItemWithTarget:self  Image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted" actionMethod:@selector(pop)];
    //设置中间标题控件
    HWTitleButton *titleButton = [HWTitleButton buttonWithType:UIButtonTypeCustom];
    //设置标题
    HWAccountModel *account = [HWAccountTool account];
    [titleButton setTitle:account.name? account.name:@"homePage" forState:UIControlStateNormal];
    //监听标题的点击
    [titleButton addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView =titleButton;
}

#pragma mark - 点击标题
/**
 图片中不规则的方向是  ：不可拉伸的方向
 */
- (void)clickTitle:(UIButton*) titleButton{
    HWDropDown *dropDwonNemu= [HWDropDown nemu];
    dropDwonNemu.delegate =self;
    //设置下拉框视图
    dropDwonNemu.contentView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 190, 217)];
    //显示下拉框
    [dropDwonNemu showFrom:titleButton];
    
}

- (void)pop{
    NSLog(@"%s",__func__);
}

- (void)friendsearch{
    NSLog(@"%s",__func__);
}

- (void)dropDownShow:(HWDropDown *)dropdown{
    UIButton *titleButton= (UIButton*)self.navigationItem.titleView;
    titleButton.selected=YES;
}
- (void)dropDownDismiss:(HWDropDown *)dropdown{
    UIButton *titleButton= (UIButton*)self.navigationItem.titleView;
    titleButton.selected=NO;

}


@end
