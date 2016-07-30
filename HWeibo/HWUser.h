//
//  HWUser.h
//  HWeibo
//
//  Created by devzkn on 7/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//https://github.com/CoderMJLee/MJExtension
//

#import <Foundation/Foundation.h>

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




@end
