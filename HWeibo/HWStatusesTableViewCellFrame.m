//
//  HWStatusesTableViewCellFrame.m
//  HWeibo
//
//  Created by devzkn on 9/19/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWStatusesTableViewCellFrame.h"



@implementation HWStatusesTableViewCellFrame

-(CGSize) sizeWithText:(NSString*)text font:(UIFont *)font{
    NSDictionary *tmpDict = @{NSFontAttributeName: font};
   return  [text sizeWithAttributes:tmpDict];
    //    CGFloat nameW = [statues.text sizeWithFont:HWNameLabelFont].width;
}

- (void)setStatues:(HWStatuses *)statues{
    _statues = statues;
    //计算控件的frame
    /** 原创微博控件*/
    /** 头像*/
    CGFloat iconWh = 50;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.iconViewFrame = CGRectMake(iconX, iconY, iconWh, iconWh);
    
    /** 昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewFrame)+HWStatusCellBorderW;
    CGFloat nameY = HWStatusCellBorderW;
    CGSize nameSize = [self sizeWithText:statues.user.name font:HWNameLabelFont];
    CGFloat nameH = nameSize.height;
    CGFloat nameW= nameSize.width;
    self.nameLabelFrame = CGRectMake(nameX, nameY, nameW, nameH);
    /** 会员图标*/
    if (self.statues.user.VIP) {
        //计算frame
        CGFloat vipX = CGRectGetMaxX(self.nameLabelFrame)+HWStatusCellBorderW;
        CGFloat vipY = HWStatusCellBorderW;
        CGFloat vipW = 14;
        CGFloat vipH = nameH;
        self.vipViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    

    /** 配图*/  

    

    /** 时间*/

    /** 来源*/

    /** 正文*/
    
    self.cellHeight = 70;

}

+ (NSArray *)listWithHWStatusesArray:(NSArray *)statusesArray{
    NSMutableArray *tmp = [NSMutableArray array];
    for (HWStatuses *obj in statusesArray) {
        [tmp addObject:[HWStatusesTableViewCellFrame statuesFrameWithStatues:obj]];
    }
    return tmp;
}

+ (instancetype)statuesFrameWithStatues:(HWStatuses *)statues{
    return [[HWStatusesTableViewCellFrame alloc]initWithStatuses:statues];
}

- (instancetype)initWithStatuses:(HWStatuses *)statues{
    self = [super init];
    if (self) {
        self.statues = statues;
    }
    return self;
}


    

@end
