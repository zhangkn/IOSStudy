//
//  HWCreatedAtTool.h
//  HWeibo
//
//  Created by devzkn on 9/25/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWCreatedAtTool : NSObject
/** 处理微博的时间格式*/
+(NSString*) processStatutesCreatedAt:(NSString*)created_at;
- (NSString *)processStatutesCreatedAt:(NSString *)created_at;

@end
