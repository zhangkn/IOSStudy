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
    self.expires_in = dict[@"expires_in"];
    return self;
}

/**
 Encodes the receiver using a given archiver. 归档的时候调用
 说明这个对象的哪些属性进行归档
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];    
}
#if 1
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.access_token=[aDecoder decodeObjectForKey:@"access_token"];
        self.uid=[aDecoder decodeObjectForKey:@"uid"];
        self.expires_in=[aDecoder decodeObjectForKey:@"expires_in"];
    }
    return self;
}// NS_DESIGNATED_INITIALIZER
#endif

@end
