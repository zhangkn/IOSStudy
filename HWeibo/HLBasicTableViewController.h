//
//  HLBasicTableViewController.h
//  HisunLottery
//
//  Created by devzkn on 4/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 根据数据模型，装配表格内容*/
@interface HLBasicTableViewController : UITableViewController
/** 数据模型*/
@property (nonatomic,strong) NSMutableArray *dataList;

@end
