//
//  HLPushTableViewController.m
//  HisunLottery
//
//  Created by devzkn on 4/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLPushTableViewController.h"
#import "HLSettingArrowItemModel.h"
#import "HLSettingCell.h"
#import "HLSettingItemGroupModel.h"
#import "HLScoreViewController.h"

@interface HLPushTableViewController ()


@end

@implementation HLPushTableViewController

- (void)group0{
    //分组模型构建
    HLSettingItemGroupModel *group = [[HLSettingItemGroupModel alloc]init];
    //构建cell对应的模型
    HLSettingArrowItemModel *push = [HLSettingArrowItemModel itemModelWithTitle:@"开奖号码推送" icon:nil destVCClass:nil];
    HLSettingArrowItemModel *anim = [HLSettingArrowItemModel itemModelWithTitle:@"中奖动画" icon:nil destVCClass:nil];
    HLSettingArrowItemModel *score = [HLSettingArrowItemModel itemModelWithTitle:@"比分直播提醒" icon:nil destVCClass:[HLScoreViewController class]];
    HLSettingArrowItemModel *lottery = [HLSettingArrowItemModel itemModelWithTitle:@"购彩定时提醒" icon:nil destVCClass:nil];
    [group setItems:@[push,anim,score,lottery]];
    [self.dataList addObject:group];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建模型
    [self group0];
}



@end
