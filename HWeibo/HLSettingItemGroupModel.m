//
//  HLSettingItemGroupModel.m
//  HisunLottery
//
//  Created by devzkn on 4/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLSettingItemGroupModel.h"
#import "HLSettingItemModel.h"

@implementation HLSettingItemGroupModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    //KVC
    self = [super init];//初始化父类属性
    if (self) {
        //初始化自身属性
        
        [self setValue:dict[@"footer"] forKey:@"footer"];
        [self setValue:dict[@"header"] forKey:@"header"];
        [self setItems:[HLSettingItemModel list:dict[@"items"]]];//利用setter方法设置cell数组
    }
    return self;
}

+ (instancetype)groupModelsWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}



@end
