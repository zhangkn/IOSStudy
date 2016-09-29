//
//  HWAccountModel.m
//  HWeibo
//
//  Created by devzkn on 7/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWAccountModel.h"
@interface HWAccountModel ()<NSCoding>

@end

@implementation HWAccountModel

+(instancetype)accountWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self.access_token = dict[@"access_token"];
    self.uid = dict[@"uid"];
//    self.name = dict[@"name"];
    self.expires_in = dict[@"expires_in"];
    //获取帐号存储时间（产生access_token的时间）
    self.createDate = [NSDate date];
    return self;
}

/**
 Encodes the receiver using a given archiver. 归档的时候调用
 说明这个对象的哪些属性进行归档
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.createDate forKey:@"createDate"];

}
#if 1
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.access_token=[aDecoder decodeObjectForKey:@"access_token"];
        self.uid=[aDecoder decodeObjectForKey:@"uid"];
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.expires_in=[aDecoder decodeObjectForKey:@"expires_in"];
        self.createDate=[aDecoder decodeObjectForKey:@"createDate"];

    }
    return self;
}// NS_DESIGNATED_INITIALIZER
#endif

@end
