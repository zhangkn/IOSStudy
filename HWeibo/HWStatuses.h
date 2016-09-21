//
//  HWStatuses.h
//  HWeibo
//
//  Created by devzkn on 7/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWUser.h"

@interface HWStatuses : NSObject
/**idstr	string	字符串型的微博ID*/
@property (nonatomic,copy) NSString *idstr;
/**text	string	微博信息内容*/
@property (nonatomic,copy) NSString *text;

/**	string	微博创建时间*/
@property (nonatomic,copy) NSString *created_at;

/** source	string	微博来源*/
@property (nonatomic,copy) NSString *source;


/**user	object	微博作者的用户信息字段 详细*/
@property (nonatomic,strong) HWUser *user;


@end
