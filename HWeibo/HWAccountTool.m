//
//  HWAccountTool.m
//  HWeibo
//
//  Created by devzkn on 7/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWAccountTool.h"

#define HWAccountArchivePath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation HWAccountTool
#pragma mark - 存储帐号信息
+ (void)saveAccount:(HWAccountModel*)account{
    //        NSString *doc = [documentDirectory stringByAppendingPathComponent:@"account.plist"];
    //        [responseObject writeToFile:doc atomically:YES];
    //自定义对象的存储
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountArchivePath];
}

#pragma mark - 获取帐号信息
+ (HWAccountModel *)account{
    //    NSDictionary *accountDict = [NSDictionary dictionaryWithContentsOfFile:path];
    HWAccountModel *acount = [NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountArchivePath];
    NSLog(@"%@",HWAccountArchivePath);
    //验证帐号是否过期
    if (acount) {
        long long expires_in=[acount.expires_in longLongValue];
        NSDate *expiresDate = [acount.createDate dateByAddingTimeInterval:expires_in];
        NSDate *nowDate = [NSDate date];
        if ([expiresDate compare:nowDate] != NSOrderedDescending) {//升序\相等，即now 》＝expiresDate 过期
            return nil;
        }
    }
    return acount;
}
@end
