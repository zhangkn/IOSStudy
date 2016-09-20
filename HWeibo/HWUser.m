//
//  HWUser.m
//  HWeibo
//
//  Created by devzkn on 7/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWUser.h"

@implementation HWUser
//- (BOOL)isVIP{
//    if (self.mbtype>2) {
//        return YES;
//    }else{
//        return NO;
//    }
//}

- (void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    self.VIP = mbtype>2;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"name: %@ mbtype: %d vip :%d mbrank: %@",self.name,self.mbtype,self.VIP,self.mbrank];
}
@end
