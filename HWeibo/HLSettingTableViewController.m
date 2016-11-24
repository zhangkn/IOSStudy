//
//  HLSettingTableViewController.m
//  HisunLottery
//
//  Created by devzkn on 4/26/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLSettingTableViewController.h"
#import "HLSettingItemGroupModel.h"
#import "HLSettingItemModel.h"
#import "HLSettingCell.h"
#import "HLSettingSwitchItemModel.h"
#import "HLSettingArrowItemModel.h"
#import "MBProgressHUD+MJ.h"
#import "HLTestViewController.h"
#import "HLProductCollectionViewController.h"
#import "HLPushTableViewController.h"
#import "HLHelpViewController.h"
#import "HLShareViewController.h"
#import "HLAboutViewController.h"
#import "DKUMShareContentViewController.h"
@interface HLSettingTableViewController ()



@end
@implementation HLSettingTableViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        //设置自己的标题
        [self.navigationItem setTitle:@"设置"];
    }
    return self;
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    //创建模型
    [self group0];
    [self group1];
    
}


- (void) group0{
    //第1组模型构建
    HLSettingItemGroupModel *group0 = [[HLSettingItemGroupModel alloc]init];
    HLSettingArrowItemModel *pushItem = [HLSettingArrowItemModel itemModelWithTitle:@"消息推送和提醒" icon:@"MorePush" destVCClass:[HLPushTableViewController class]];
    HLSettingSwitchItemModel *handShakeItem = [HLSettingSwitchItemModel itemModelWithTitle:@"摇一摇机选" icon:@"handShake"];
    HLSettingSwitchItemModel *sound_EffectItme = [HLSettingSwitchItemModel itemModelWithTitle:@"声音效果" icon:@"sound_Effect"];
    group0.items = @[pushItem,handShakeItem,sound_EffectItme];
    [self.dataList addObject:group0];
}


- (void) group1{
    //第二组模型构建
    HLSettingItemGroupModel *group1 = [[HLSettingItemGroupModel alloc]init];
    HLSettingArrowItemModel *moreUpdateItem = [HLSettingArrowItemModel itemModelWithTitle:@"检查更新" icon:@"MoreUpdate"];
    //定义点击更新的block
    [moreUpdateItem setOptionBlock:^{
        //显示蒙板
        [MBProgressHUD showMessage:@"检查版本信息..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //关闭蒙板
            [MBProgressHUD hideHUD];
            //显示提示信息
            UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"有新版本" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"立即更新", nil];
            [alterView show];
        });
        
    }];
    HLSettingArrowItemModel *moreHelpDictItem = [HLSettingArrowItemModel itemModelWithTitle:@"帮助" icon:@"MoreHelp" destVCClass:[HLHelpViewController class]];
    HLSettingArrowItemModel *moreShareItem = [HLSettingArrowItemModel itemModelWithTitle:@"分享" icon:@"MoreShare" destVCClass:[HLShareViewController class]];
//    HLSettingArrowItemModel *moreShareItem = [HLSettingArrowItemModel itemModelWithTitle:@"分享" icon:@"MoreShare" destVCClass:[DKUMShareContentViewController class]];

    HLSettingArrowItemModel *moreMessageItem = [HLSettingArrowItemModel itemModelWithTitle:@"查看消息" icon:@"MoreMessage" destVCClass:[HLTestViewController class]];
    HLSettingArrowItemModel *moreNeteaseItem = [HLSettingArrowItemModel itemModelWithTitle:@"产品推荐" icon:@"MoreNetease" destVCClass:[HLProductCollectionViewController class]];
    HLSettingArrowItemModel *moreAboutItem = [HLSettingArrowItemModel itemModelWithTitle:@"关于" icon:@"MoreAbout" destVCClass:[HLAboutViewController class]];
    
    group1.items = @[moreUpdateItem,moreHelpDictItem,moreShareItem,moreMessageItem,moreNeteaseItem,moreAboutItem];
    [self.dataList addObject:group1];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
    
}


@end
