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
#import "HWLoadMoreDateFooterView.h"
#import "HWStatusesTableViewCell.h"
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
    //集成上拉刷新控件
    [self setupRefresh];
    //集成下拉获取更多数据控件
    [self setupLoadMoreDateFooterViewWithTableView];
    //获取未读书
    NSTimer *timer = [NSTimer timerWithTimeInterval:300 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];//主线程会并发的处理timer事件

}

#pragma mark - 获取未读消息数
/** 
 http://open.weibo.com/wiki/2/remind/unread_count
 URL
 
 请求参数
 必选	类型及范围	说明
 source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 uid	true	int64	需要获取消息未读数的用户UID，必须是当前登录用户。
 callback	false	string	JSONP回调函数，用于前端调用返回JS格式的信息。
 unread_message	false	boolean	未读数版本。0：原版未读数，1：新版未读数。默认为0。
 
 字段说明
 返回值字段	字段类型	字段说明
 status	int	新微博未读数
 follower	int	新粉丝数
 cmt	int	新评论数
 dm	int	新私信数
 mention_status	int	新提及我的微博数
 mention_cmt	int	新提及我的评论数
 group	int	微群消息未读数
 private_group	int	私有微群消息未读数
 notice	int	新通知未读数
 invite	int	新邀请未读数
 badge	int	新勋章数
 photo	int	相册消息未读数
 msgbox	int	{{{3}}}
 */
- (void)setupUnreadCount{
    NSLog(@"%s",__func__);
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //设置请求参数
    NSString *url =@"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    HWAccountModel *account = [HWAccountTool account];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    parameters[@"unread_message"] = @"1";
    [mgr GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //处理json数据
        //使用模型进程存储
        //将NSnumber 对象转化为字符串description
        NSString *status = [responseObject[@"status"] description];// status	int	新微博未读数
        if ([status isEqualToString:@"0"]) {
            //清空未读消息数量
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
        NSLog(@"status:%@",status);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 添加上拉获取更多数据的控件
- (void)setupLoadMoreDateFooterViewWithTableView{
    [HWLoadMoreDateFooterView loadMoreDateFooterViewWithTableView:self.tableView];
    self.tableView.tableFooterView.hidden = YES;
}
/**
 contentInset：除具体内容以外的边框尺寸
 contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
 contentOffset:
 1.它可以用来判断scrollView滚动到什么位置
 2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
 */
#pragma mark - 显示tableFooterView，并加在数据
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 如果tableView还没有数据，就直接返回
    if (self.statuses.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    //当前的scrollView滚动的位置
    CGFloat curruentContentOffSetY = scrollView.contentOffset.y;

    //完全显示最后一个cell的时候的ContentOffSetY
    CGFloat judgeOffsetY=scrollView.contentSize.height+scrollView.contentInset.bottom-scrollView.height-self.tableView.tableFooterView.height;

    if (curruentContentOffSetY>judgeOffsetY) {//意味着要显示tableFooterView
        self.tableView.tableFooterView.hidden = NO;
        //加载更多数据
        [self loadMoreStatus];
    }
}
#pragma mark - 加载数据，加载完毕隐藏tableFooterView
- (void)loadMoreStatus{
    //创建管理器
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    HWAccountModel *account = [HWAccountTool account];
    parameters[@"access_token"]= account.access_token;
    
    HWStatuses *lastStatuse =[self.statuses lastObject];
    if (lastStatuse) {
//        max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatuse.idstr.longLongValue - 1;
        parameters[@"max_id"] = @(maxId);
    }
    //    parameters[@"count"]= @20;
    NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
    //    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    [mgr GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSArray *tmpArray  = [HWStatuses mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        if (tmpArray.count !=0) {
            [self.statuses addObjectsFromArray:tmpArray];
            //刷新数据
            [self.tableView reloadData];
        }
        //隐藏tableFooterView
        self.tableView.tableFooterView.hidden= YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 添加下拉刷新按钮
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
    // 刷新成功(清空图标数字)
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    UILabel *numLabel = [[UILabel alloc]init];
    numLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
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
   
    //设置个性属性
#warning HWStatusesTableViewCellFrame
    HWStatusesTableViewCellFrame *statusF = self.statuses[indexPath.row];
    HWStatusesTableViewCell *cell = [HWStatusesTableViewCell tableVieCellWithFrameModel:statusF tableView:tableView];    
////    user	object	微博作者的用户信息字段 详细
//    HWUser *user = status.user;
//    cell.textLabel.text =user.name;
//    cell.detailTextLabel.text =status.text;
//    NSString *avatarLargeUrl =user.profile_image_url;
//    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
//    NSURL *url =[NSURL URLWithString:avatarLargeUrl];    
//    [cell.imageView sd_setImageWithURL:url placeholderImage:placeholderImage];
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
