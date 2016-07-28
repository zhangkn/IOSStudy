//
//  HWAccountTool.h
//  HWeibo
//
//  Created by devzkn on 7/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWAccountModel;
@interface HWAccountTool : NSObject
+ (void)saveAccount:(HWAccountModel*)account;
/** 
 返回可用的帐号信息（ 如果帐号过期，返回nil）
 */
+ (HWAccountModel*)account;



@end
