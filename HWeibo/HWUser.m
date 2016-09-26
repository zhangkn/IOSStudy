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
    return [NSString stringWithFormat:@"name: %@ mbtype: %d vip :%d mbrank: %@  verified_type:%d",self.name,self.mbtype,self.VIP,self.mbrank,self.verified_type];
}


- (UIImage *)setupVerified_typeImage:(HWUserVerifiedType)verified_type{
    switch (verified_type) {
        case HWUserVerifiedTypeNone:
            _verified_typeImage = [UIImage imageNamed:@"avatar_default"];
            break;
        case HWUserVerifiedTypeAvatarVip:
            _verified_typeImage = [UIImage imageNamed:@"avatar_vip"];
            break;
        case HWUserVerifiedTypeAvatarVgirl:
            _verified_typeImage = [UIImage imageNamed:@"avatar_vgirl"];
            break;
        case HWUserVerifiedTypeAvatarGrassroot:
            _verified_typeImage = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        case HWUserVerifiedTypeAvatarEnterpriseVip2:
        case HWUserVerifiedTypeAvatarEnterpriseVip3:
        case HWUserVerifiedTypeAvatarEnterpriseVip5:
            _verified_typeImage = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
    }
    return _verified_typeImage;
}

- (void)setVerified_type:(HWUserVerifiedType)verified_type{
    _verified_type = verified_type;
    //设置对应的V类型图标
    [self setupVerified_typeImage:verified_type];
    if ([self.name isEqualToString:@"CSDN程序人生"] || [self.name isEqualToString:@"世界经理人网站"]) {
        NSLog(@"_name:%@  _verified_type:%d",self.name,_verified_type);
    }
//
//    if (verified_type == 3){//开源中国=2 世界经理人网站 =3
//        NSLog(@"_name:%@  _verified_type:%d",self.name,_verified_type);
//    }
//    
}
@end
