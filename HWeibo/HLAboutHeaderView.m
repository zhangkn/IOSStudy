//
//  HLAboutHeaderView.m
//  HisunLottery
//
//  Created by devzkn on 4/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLAboutHeaderView.h"

@implementation HLAboutHeaderView

+ (instancetype)tableViewHeaderView{
    HLAboutHeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"HLAboutHeaderView" owner:nil options:nil]lastObject];
    return headerView;
}

@end
