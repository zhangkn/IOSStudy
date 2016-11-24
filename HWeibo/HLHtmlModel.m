//
//  HLHtmlModel.m
//  HisunLottery
//
//  Created by devzkn on 4/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLHtmlModel.h"

@implementation HLHtmlModel


- (instancetype)initWithDictionary:(NSDictionary *)dict{
    //KVC
    self = [super init];//初始化父类属性
    if (self) {
        //初始化自身属性
        [self setValue:dict[@"title"] forKey:@"title"];
        [self setValue:dict[@"id"] forKey:@"ID"];
        [self setValue:dict[@"html"] forKey:@"html"];
    }
    return self;
}
+ (instancetype)htmlWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

+ (NSArray *)list{
    NSMutableArray *tmpArrayM = [NSMutableArray array];
    //解析plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error ;
    NSArray *arrayDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (arrayDict && error == nil) {
        for (NSDictionary *dict in  arrayDict) {
            [tmpArrayM addObject:[self htmlWithDictionary:dict]];
        }
        return tmpArrayM;
    }else{
        return nil;
    }
}


@end
