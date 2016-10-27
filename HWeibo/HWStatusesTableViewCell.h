//
//  HWStatusesTableViewCell.h
//  HWeibo
//
//  Created by devzkn on 9/19/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWStatusesTableViewCellFrame.h"
#import "HWStatueTextView.h"
@interface HWStatusesTableViewCell : UITableViewCell

//自定义视图的现实的数据来源于模型，即使用模型装配自定义视图的显示内容
@property (nonatomic,strong) HWStatusesTableViewCellFrame *frameModel;//视图对应的模型，是视图提供给外界的接口
+ (instancetype) tableViewCellWithTableView:(UITableView *) tableView;//使用类方法加载xib
/**
 通过数据模型设置视图内容，可以让视图控制器不需要了解视图的细节
 */
+ (instancetype) tableVieCellWithFrameModel:(HWStatusesTableViewCellFrame *) frameModel tableView:(UITableView *)tableView;//使用类方法加载xib,参数用于视图的数据装配

@end
