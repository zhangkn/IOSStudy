//
//  HLHelpViewController.m
//  HisunLottery
//
//  Created by devzkn on 4/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLHelpViewController.h"
#import "HLSettingArrowItemModel.h"
#import "HLSettingItemGroupModel.h"
#import "HLHtmlModel.h"
#import "HLHtmlViewController.h"
#import "HLNavigationController.h"



@interface HLHelpViewController ()
@property (nonatomic,strong) NSArray *htmls;

@end

@implementation HLHelpViewController

- (NSArray *)htmls{
    if (nil == _htmls) {
        _htmls = [HLHtmlModel list];
    }
    return _htmls;
}
/**构建帮助页面的分组 */
- (void)group0{
    //构建cell对应的模型
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (HLHtmlModel* htmlModel in self.htmls) {
        HLSettingArrowItemModel *arrowItemModel = [HLSettingArrowItemModel itemModelWithTitle:htmlModel.title icon:nil destVCClass:nil];
        [tmpArray addObject:arrowItemModel];
    }
    //分组模型对象的构建
    HLSettingItemGroupModel *group = [[HLSettingItemGroupModel alloc]init];
    [group setItems:tmpArray];
    [self.dataList addObject:group];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建模型
    [self group0];
}

#pragma mark  -  重写

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //取出模型
    HLHtmlModel *itemModel = self.htmls[indexPath.row];
    //控制器跳转
    HLHtmlViewController *htmlVC = [[HLHtmlViewController alloc]init];
    [htmlVC setTitle:itemModel.title];
    [htmlVC setHtmlModel:itemModel];
    HLNavigationController *navigationVc = [[HLNavigationController alloc]initWithRootViewController:htmlVC];
    [self presentViewController:navigationVc animated:YES completion:^{
        //
    }];
}
    


@end
