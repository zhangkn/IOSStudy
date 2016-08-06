//
//  HWLoadMoreDateFooterView.m
//  HWeibo
//
//  Created by devzkn on 8/6/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWLoadMoreDateFooterView.h"

@implementation HWLoadMoreDateFooterView
+ (instancetype)loadMoreDateFooterViewWithTableView:(UITableView *)tableView{
    HWLoadMoreDateFooterView *loadMoreDateFooterView = [[[NSBundle mainBundle] loadNibNamed:@"HWLoadMoreDateFooterView" owner:nil options:nil]lastObject];
    tableView.tableFooterView = loadMoreDateFooterView;
    loadMoreDateFooterView.width = KMainScreenWidth;
    return loadMoreDateFooterView;
}


@end
