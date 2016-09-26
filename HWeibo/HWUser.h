//
//  HWUser.h
//  HWeibo
//
//  Created by devzkn on 7/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//https://github.com/CoderMJLee/MJExtension
//

#import <Foundation/Foundation.h>
typedef enum {
    HWUserVerifiedTypeNone = -1 ,//未认证
    HWUserVerifiedTypeAvatarVip = 0 ,//个人认证
    HWUserVerifiedTypeAvatarEnterpriseVip2 = 2, //企业官方认证
    HWUserVerifiedTypeAvatarEnterpriseVip3 = 3, //媒体官方认证
    HWUserVerifiedTypeAvatarEnterpriseVip5 = 5, //网站官方认证
    HWUserVerifiedTypeAvatarVgirl = 10 ,//微女郎
    HWUserVerifiedTypeAvatarGrassroot = 220,//微博达人
} HWUserVerifiedType;

@interface HWUser : NSObject
/**idstr	string	字符串型的用户UID*/
@property (nonatomic,copy) NSString *idstr;
/*
screen_name	string	用户昵称*/
/** name	string	友好显示名称*/
@property (nonatomic,copy) NSString *name;
/**
province	int	用户所在省级ID
city	int	用户所在城市ID
location	string	用户所在地
description	string	用户个人描述
url	string	用户博客地址*/

/** reposts_count	int	转发数
 comments_count	int	评论数*/

/** profile_image_url	string	用户头像地址（中图），50×50像素*/

@property (nonatomic,copy) NSString *profile_image_url;
/** 会员等级*/
@property (nonatomic,copy) NSString *mbrank;

/** 会员类型 》2 会员*/
@property (nonatomic,assign) int mbtype;
@property (nonatomic,assign,getter=isVIP) BOOL VIP;

/**	boolean	是否是微博认证用户，即加V用户，true：是，false：否*/
@property (nonatomic,assign,) BOOL verified;
/** 认证类型	int	暂未支持   -1  未认证   个人认证  _verified_type:0   企业认证（官方）  _verified_type:2  企业认证   _verified_type:3   企业认证   _verified_type:5   微女郎  _verified_type:10  微博达人  _verified_type:220
*/
@property (nonatomic,assign) HWUserVerifiedType verified_type;

@property (nonatomic,strong) UIImage *verified_typeImage;






@end
