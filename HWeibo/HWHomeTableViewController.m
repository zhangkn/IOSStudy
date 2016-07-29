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
#import "UIImageView+WebCache.h"

@interface HWHomeTableViewController ()<HWDropDownDelagate>
/** 微博数组：每一个元素（字典）代表一条微博信息*/
@property (nonatomic,strong) NSArray *statuses;

@end

@implementation HWHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setNavigationContent];
    //获取用户信息
    [self getUserInfo];
    //获取当前登录用户及其所关注（授权）用户的最新微博
    [self homeTimeline];
  

}
#pragma mark - 获取获取当前登录用户及其所关注（授权）用户的最新微博
/** 请求参数
 必选	类型及范围	说明
 access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
 since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 count	false	int	单页返回的记录条数，最大不超过100，默认为20。
 page	false	int	返回结果的页码，默认为1。
 base_app	false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 feature	false	int	过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 trim_user	false	int	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。**/
- (void)homeTimeline{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    HWAccountModel *account = [HWAccountTool account];
    parameters[@"access_token"]= account.access_token;
//    parameters[@"count"]= @20;
    NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
//    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    [mgr GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //设置首页标题文字
        NSLog(@"%@",responseObject);
        self.statuses = responseObject[@"statuses"];
        //刷新数据
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statuses.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString  *identifier =@"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        //设置共性属性
    }
    //设置个性属性
    NSDictionary *status = self.statuses[indexPath.row];
//    user	object	微博作者的用户信息字段 详细
    NSDictionary *user = status[@"user"];
    cell.textLabel.text =user[@"name"];
    cell.detailTextLabel.text =status[@"text"];
    NSString *avatarLargeUrl =user[@"avatar_large"];//用户头像地址（大图），180×180像素
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
    NSURL *url =[NSURL URLWithString:avatarLargeUrl];    
    [cell.imageView sd_setImageWithURL:url placeholderImage:placeholderImage];
    return cell;
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
//        NSLog(@"%@",responseObject);
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
