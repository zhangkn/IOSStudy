//
//  HLBasicTableViewController.m
//  HisunLottery
//
//  Created by devzkn on 4/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLBasicTableViewController.h"
#import "HLSettingCell.h"
#import "HLSettingItemGroupModel.h"
#import "HLSettingItemModel.h"
#import "HLSettingSwitchItemModel.h"
#import "HLSettingArrowItemModel.h"

@interface HLBasicTableViewController ()


@end

@implementation HLBasicTableViewController

- (NSMutableArray *)dataList{
    if (nil == _dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        //设置子控制器的放回按钮文字
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:self.navigationItem.title style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:barButtonItem];
    }
    return self;
}

#pragma mark - tableViewDelegate

- (NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    HLSettingItemGroupModel *group = self.dataList[section];
    return group.footer;
    
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    HLSettingItemGroupModel *group = self.dataList[section];
    return group.header;
    
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HLSettingItemGroupModel *group = self.dataList[indexPath.section];
    HLSettingItemModel *itemModel = group.items[indexPath.row];
    HLSettingCell *cell =[HLSettingCell tableVieCellWithItemModel:itemModel tableView:tableView];
    [cell setIndexPath:indexPath];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HLSettingItemGroupModel *group = self.dataList[section];
    return group.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}
#pragma mark - didSelectRowAtIndexPath

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //取出模型
    HLSettingItemGroupModel *group = self.dataList[indexPath.section];
    HLSettingItemModel *itemModel = group.items[indexPath.row];
    
    //执行optionBlock
    if (itemModel.optionBlock) {
        itemModel.optionBlock();
        return;
    }
    //控制器跳转
    if ([itemModel isKindOfClass:[HLSettingArrowItemModel class]]) {
        HLSettingArrowItemModel *arrowItemModel = (HLSettingArrowItemModel*) itemModel;
        if (arrowItemModel.destVCClass) {
            //控制器跳转
            UIViewController *vc = [[arrowItemModel.destVCClass alloc]init];
            [vc setTitle:itemModel.title];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 适配代码
- (void)viewDidLoad{
    [self.tableView setBackgroundView:nil];//IOS6的优先级 setBackgroundView》setBackgroundColor
    [self.tableView setBackgroundColor:HWColor(244, 243, 241)];
    //设置分组的头部和尾部高度
    [self.tableView setSectionFooterHeight:0];
    [self.tableView setSectionHeaderHeight:20];
    if (IOS7) {
        CGFloat x = -15;//与第一个cell的Y值有关
        [self.tableView setContentInset:UIEdgeInsetsMake(x, 0, 0, 0)];
    }
}


    

@end
