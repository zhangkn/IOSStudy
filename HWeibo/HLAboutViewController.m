//
//  HLAboutViewController.m
//  HisunLottery
//
//  Created by devzkn on 4/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLAboutViewController.h"
#import "HLSettingItemGroupModel.h"
#import "HLSettingArrowItemModel.h"
#import "HLAboutHeaderView.h"
@interface HLAboutViewController ()
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation HLAboutViewController

- (UIWebView *)webView{
    if (nil == _webView) {
        _webView = [[UIWebView alloc]init];
    }
    return _webView;
}

- (void)viewDidLoad {
    NSLog(@"%s",__func__);

    [super viewDidLoad];
    [self addGroup0];
    //设置tableView的headerView
    [self.tableView setTableHeaderView:[HLAboutHeaderView tableViewHeaderView]];

}

- (void)addGroup0{
    __weak HLAboutViewController *aboutVC = self;
    HLSettingItemGroupModel *group = [[HLSettingItemGroupModel alloc]init];
    HLSettingArrowItemModel *scoreItem = [HLSettingArrowItemModel itemModelWithTitle:@"评分支持" icon:@"" destVCClass:nil];
    //跳转到App Store评分
    [scoreItem setOptionBlock:^{
        NSString *appId = @"425349261";//网易新闻
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@?mt=8",appId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    HLSettingArrowItemModel *telItem = [HLSettingArrowItemModel itemModelWithTitle:@"客服电话" icon:@"" destVCClass:nil];
    [telItem setSubTitle:@"1887405487"];
    [telItem setOptionBlock:^{
//        NSString *str = [NSString stringWithFormat:@"tel://%@",@"1887405487"];//不会自动回到原应用，直接停留在通话记录页面
//        NSString *str = [NSString stringWithFormat:@"telprompt://%@",@"1887405487"];//拨号之前会弹框询问用户是否拨号，拨完号之后能自动回到原应用－－缺点：因为是私有API，可能会审核不通过
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

        //方式三：创建一个UIWebView来加载URL，拨完号之后能自动回到原界面
        NSURL *url = [NSURL URLWithString:@"tel:1887405487"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [aboutVC.webView loadRequest:request];
        
    }];
    [group setItems:@[scoreItem,telItem]];
    [self.dataList addObject:group];
}

#if 1
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
#endif

-(void)dealloc{
    NSLog(@"%s",__func__);
}
    


@end
