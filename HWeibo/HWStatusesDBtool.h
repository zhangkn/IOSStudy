//
//  HWStatusesDBtool.h
//  HWeibo
//
//  Created by devzkn on 21/11/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface HWStatusesDBtool : NSObject


+ (NSArray*)statusesWithparameters:(NSDictionary*)parameters;

+ (void)savestatusesWithStatuses:(NSArray*)statuses;


@end
