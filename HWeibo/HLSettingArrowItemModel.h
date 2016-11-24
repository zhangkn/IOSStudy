//
//  HLSettingArrowItemModel.h
//  HisunLottery
//
//  Created by devzkn on 4/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLSettingItemModel.h"

@interface HLSettingArrowItemModel : HLSettingItemModel
@property (nonatomic,assign) Class destVCClass;//目标控制器的Classe

+ (instancetype)itemModelWithTitle:(NSString *)title icon:(NSString *)icon destVCClass:(Class)destVCClass;

@end
