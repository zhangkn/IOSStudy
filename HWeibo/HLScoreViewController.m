//
//  HLScoreViewController.m
//  HisunLottery
//
//  Created by devzkn on 4/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLScoreViewController.h"
#import "HLSettingLabeltemModel.h"
#import "HLSettingSwitchItemModel.h"
#import "HLSettingItemGroupModel.h"
#import "HLSaveTool.h"

@interface HLScoreViewController ()

@property (nonatomic,strong) HLSettingLabeltemModel *startModel;

@end

@implementation HLScoreViewController

- (HLSettingLabeltemModel *)startModel{
    if (nil == _startModel) {
        HLSettingLabeltemModel *labelModel = [HLSettingLabeltemModel itemModelWithTitle:@"开始时间" icon:@""];
        if (labelModel.text.length == 0) {//        NSString *text =[HLSaveTool objectForKey:labelModel.title]; 放置于setTitle--        //先从偏好设置获取
            [labelModel setText:@"00:00"];
        }
        /**
         定义展示键盘的block
         */
        __weak HLBasicTableViewController *basicVC = self;
        [labelModel setOptionBlock:^{
            UITextField *tmpTextField = [[UITextField alloc]init];
            [basicVC.view addSubview:tmpTextField];
            //设置键盘类型
            UIDatePicker *datePicker = [[UIDatePicker alloc]init];
            [datePicker setDatePickerMode:UIDatePickerModeTime];
            NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
            [datePicker setLocale:locale];//本地化
            //设置日期格式
            NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
            [dateF setDateFormat:@"HH:mm"];
            NSDate *date = [dateF  dateFromString:@"01:00"];//设置默认日期
            [datePicker setDate:date animated:YES];
            [tmpTextField setInputView:datePicker];
            //监听事件滚动
            [datePicker addTarget:basicVC action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
            //展示日期键盘
            [tmpTextField becomeFirstResponder];
            
        }];
        _startModel = labelModel;
        
    }
    return _startModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加模型
    [self addGroup0];
    [self addGroup1];
    [self addGroup2];


}

- (void) addGroup0{
    HLSettingItemGroupModel *group = [[HLSettingItemGroupModel alloc]init];
    HLSettingSwitchItemModel *switchItemModel = [HLSettingSwitchItemModel itemModelWithTitle:@"提醒我关注比赛" icon:@""];
    [group setItems:@[switchItemModel]];
    [group setFooter:@"当我关注比赛比分发生变化时，通过小浮窗或者推送进行提醒"];
    [self.dataList addObject:group];
}

- (void) addGroup1{
    HLSettingItemGroupModel *group = [[HLSettingItemGroupModel alloc]init];
    [group setItems:@[self.startModel]];
    [group setHeader:@"只在以下时间接受比分直播"];
    [self.dataList addObject:group];
}

#pragma  mark - valueChange 处理日期选择
- (void) valueChange:(UIDatePicker*)datePicker{
    //修改模型
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    [self.startModel setText:[formatter stringFromDate:datePicker.date]];////    [HLSaveTool setObject:self.startModel.text forKey:self.startModel.title]; 在setter中执行－－    //存储编好设置
    //刷新数据
    [self.tableView reloadData];
    NSLog(@"%@",datePicker.date);
}


- (void) addGroup2{
    HLSettingItemGroupModel *group = [[HLSettingItemGroupModel alloc]init];
    HLSettingLabeltemModel *labelModel = [HLSettingLabeltemModel itemModelWithTitle:@"结束时间" icon:@""];
    [labelModel setText:@"00:00"];
    [group setItems:@[labelModel]];
    [self.dataList addObject:group];
}


- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
