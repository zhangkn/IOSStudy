//
//  HWStatuses.h
//  HWeibo
//
//  Created by devzkn on 7/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWUser.h"
#import "HWPhoto.h"
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

/**		微博配图 字典数组[
 {
	thumbnail_pic = http://ww2.sinaimg.cn/thumbnail/005SWs8tjw1f817kxjo9pj311t1eeag5.jpg
 },
 {
	thumbnail_pic = http://ww1.sinaimg.cn/thumbnail/005SWs8tjw1f817kym4exj311t1eejxa.jpg
 },
 {
	thumbnail_pic = http://ww3.sinaimg.cn/thumbnail/005SWs8tjw1f817kz6f2dj30dc0hsgml.jpg
 },
 {
	thumbnail_pic = http://ww4.sinaimg.cn/thumbnail/005SWs8tjw1f817kzskwoj30dc0hsdh6.jpg
 },
 {
	thumbnail_pic = http://ww1.sinaimg.cn/thumbnail/005SWs8tjw1f817l0g18jj30dc0hsdhe.jpg
 },
 {
	thumbnail_pic = http://ww2.sinaimg.cn/thumbnail/005SWs8tjw1f817l136e1j30dc0hsq4p.jpg
 },
 {
	thumbnail_pic = http://ww1.sinaimg.cn/thumbnail/005SWs8tjw1f817l1qojlj30dc0hs400.jpg
 },
 {
	thumbnail_pic = http://ww3.sinaimg.cn/thumbnail/005SWs8tjw1f817l2e4yej30dc0hs3zw.jpg
 },
 {
	thumbnail_pic = http://ww2.sinaimg.cn/thumbnail/005SWs8tjw1f817l30xryj30dc0hsac0.jpg
 }
 ]。*/
@property (nonatomic,strong) NSArray *pic_urls;

/**	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细*/
@property (nonatomic,strong) HWStatuses *retweeted_status;
/** 	int	转发数*/
@property (nonatomic,assign) int reposts_count;
/** 	int	评论数*/
@property (nonatomic,assign) int comments_count;
/**	int	表态数*/
@property (nonatomic,assign) int attitudes_count;

@end
