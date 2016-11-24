//
//  HLSettingItemModel.m
//  HisunLottery
//
//  Created by devzkn on 4/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLSettingItemModel.h"

@implementation HLSettingItemModel
@synthesize iconImage = _iconImage;

- (UIImage *)iconImage{
    if (nil == _iconImage) {
        if (self.icon.length == 0) {//2016-04-29 10:33:43.831 HisunLottery[2555:112906] CUICatalog: Invalid asset name supplied: [UIImage imageNamed:name];但是这个name却是空的，所以就报了这个错了
            return nil;
        }
        _iconImage = [UIImage imageNamed:self.icon];
    }
    return _iconImage;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    //KVC
    self = [super init];//初始化父类属性
    if (self) {
        //初始化自身属性
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)itemModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

+ (NSArray *)list:(NSArray *)arrayDict{
    NSMutableArray *tmpArrayM = [NSMutableArray array];
    //解析plist
    for (NSDictionary *dict in  arrayDict) {
        [tmpArrayM addObject:[self itemModelWithDictionary:dict]];
    }
    return tmpArrayM;
}

+ (instancetype)itemModelWithTitle:(NSString *)title icon:(NSString *)icon{
    if (title.length == 0) {
        title = @"";
    }
    if (icon.length == 0) {
        icon = @"";
    }    
    NSDictionary *dict = @{@"title":title,@"icon":icon};
    return [[self alloc]initWithDictionary:dict];
}



@end
