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
#import "HWClearCacheView.h"

#import "HLSettingLabeltemModel.h"
@interface HLSettingTableViewController ()

@property (nonatomic,strong) HLSettingLabeltemModel *settingLabeltemModel;
@property (nonatomic,strong) HWClearCacheView *clearCacheView;



@end
@implementation HLSettingTableViewController

- (HWClearCacheView *)clearCacheView{
    if (_clearCacheView == nil) {
        _clearCacheView = [[[NSBundle mainBundle] loadNibNamed:@"HWClearCacheView" owner:self options:nil]firstObject];
    }
    return _clearCacheView;
}


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
#pragma mark - 构建清理缓存模型
- (HLSettingLabeltemModel *)settingLabeltemModel{
    if (_settingLabeltemModel == nil) {
        HLSettingLabeltemModel *settingLabeltemModel = [HLSettingLabeltemModel itemModelWithTitle:@"Clear cache" icon:@""];
        if (settingLabeltemModel.text.length == 0) {//        NSString *text =[HLSaveTool objectForKey:labelModel.title]; 放置于setTitle--        //先从偏好设置获取
#warning 设置cache
            [settingLabeltemModel setText:@"234M"];
        }
        /**
         定义clear cache的block
         */
        __weak HLSettingTableViewController *weakself = self;
        [settingLabeltemModel setOptionBlock:^{
           //展示清理缓存的页面
            [WINDOWFirst addSubview:weakself.clearCacheView];
        }];
        
        _settingLabeltemModel = settingLabeltemModel;
        
    }
    return _settingLabeltemModel;
}

- (void) group0{
    //第1组模型构建
    HLSettingItemGroupModel *group0 = [[HLSettingItemGroupModel alloc]init];
    HLSettingArrowItemModel *pushItem = [HLSettingArrowItemModel itemModelWithTitle:@"消息推送和提醒" icon:@"MorePush" destVCClass:[HLPushTableViewController class]];
    HLSettingSwitchItemModel *handShakeItem = [HLSettingSwitchItemModel itemModelWithTitle:@"摇一摇机选" icon:@"handShake"];
    HLSettingSwitchItemModel *sound_EffectItme = [HLSettingSwitchItemModel itemModelWithTitle:@"声音效果" icon:@"sound_Effect"];
    
    HLSettingLabeltemModel *settingLabeltemModel = [self settingLabeltemModel];
    
    group0.items = @[pushItem,handShakeItem,sound_EffectItme,settingLabeltemModel];
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
