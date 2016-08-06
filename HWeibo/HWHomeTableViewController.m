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
#import "HWUser.h"
#import "HWStatuses.h"
#import "MJExtension.h"

@interface HWHomeTableViewController ()<HWDropDownDelagate>
/** 微博数组：每一个元素（字典）代表一条微博信息*/
@property (nonatomic,strong) NSMutableArray *statuses;

@end

@implementation HWHomeTableViewController

- (NSMutableArray *)statuses{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setNavigationContent];
    //获取用户信息
    [self getUserInfo];
    //获取当前登录用户及其所关注（授权）用户的最新微博
    //集成刷新控件
    [self setupRefresh];
  

}

- (void)setupRefresh{
    //添加控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshControlEventValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    // //刷新数据
    [refreshControl beginRefreshing];//不会触发UIControlEventValueChanged
    [self refreshControlEventValueChanged:refreshControl];
    
}
#pragma mark - 刷新控件的监听方法
- (void)refreshControlEventValueChanged:(UIRefreshControl*)refreshControl{
    //进入刷新状态
    [self refreshHomeTimeline:refreshControl];
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

- (void)refreshHomeTimeline:(UIRefreshControl*)refreshControl{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    HWAccountModel *account = [HWAccountTool account];
    parameters[@"access_token"]= account.access_token;
    HWStatuses *firstStatuse =[self.statuses firstObject];
    if (firstStatuse) {
        parameters[@"since_id"]= firstStatuse.idstr;
    }
    //    parameters[@"count"]= @20;
    NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
    //    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    [mgr GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSArray *tmpArray  = [HWStatuses mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        if (tmpArray.count !=0) {
            NSRange range = NSMakeRange(0, tmpArray.count);
            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
            [self.statuses insertObjects:tmpArray atIndexes:set];
            //刷新数据
            [self.tableView reloadData];
            //显示最新微博数量
            [self showNewStatusesCount:tmpArray.count];
        }
        NSLog(@"%@",[(HWStatuses*)self.statuses[0] text]);
        [refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [refreshControl endRefreshing];
    }];
}
#pragma mark -  显示刷新的微博数量
- (void)showNewStatusesCount:(long)count{
    if (count==0) {
        return;
    }
    UILabel *numLabel = [[UILabel alloc]init];
    numLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
#define KMainScreenWidth [UIScreen mainScreen].bounds.size.width
    numLabel.width =KMainScreenWidth;
    numLabel.height = 20;
    numLabel.y = 64 - numLabel.height;
    numLabel.text =[NSString stringWithFormat:@"%ld new weibo",count];
    numLabel.textColor = [UIColor whiteColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.view insertSubview:numLabel belowSubview:self.navigationController.navigationBar];
    
    //动画显示numLabel
    [UIView animateWithDuration:1.0 animations:^{
        //下拉numlabel
//        numLabel.y = numLabel.y+numLabel.height;
        numLabel.transform = CGAffineTransformMakeTranslation(0, numLabel.height);
    } completion:^(BOOL finished) {
        //恢复y值
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            numLabel.y = numLabel.y - numLabel.height;
            numLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //删除\隐藏numlabel
//            numLabel.bounds = CGRectZero;
            [numLabel removeFromSuperview];
        }];
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
    HWStatuses *status = self.statuses[indexPath.row];
//    user	object	微博作者的用户信息字段 详细
    HWUser *user = status.user;
    cell.textLabel.text =user.name;
    cell.detailTextLabel.text =status.text;
    NSString *avatarLargeUrl =user.profile_image_url;
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
    //再次布局下子控件
    [titleButton layoutSubviews];
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
