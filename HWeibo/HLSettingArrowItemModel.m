//
//  HLSettingArrowItemModel.m
//  HisunLottery
//
//  Created by devzkn on 4/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLSettingArrowItemModel.h"

@implementation HLSettingArrowItemModel

+ (instancetype)itemModelWithTitle:(NSString *)title icon:(NSString *)icon destVCClass:(Class)destVCClass{
    HLSettingArrowItemModel *item = [super itemModelWithTitle:title icon:icon];
    [item setDestVCClass:destVCClass];
    return item;
}


@end
