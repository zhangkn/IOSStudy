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
    /** 方式一*/
//    NSDictionary *tmpDict = @{NSFontAttributeName: font};
//   return  [text sizeWithAttributes:tmpDict];
    /** 方式2*/
    //    CGFloat nameW = [statues.text sizeWithFont:HWNameLabelFont].width;
    /** 方式3*/
    return  [self sizeWithText:text font:font maxW:CGFLOAT_MAX];
}
-(CGSize) sizeWithText:(NSString*)text font:(UIFont *)font maxW:(CGFloat)maxW{
    NSDictionary *tmpDict = @{NSFontAttributeName: font};
    CGSize maxSize = CGSizeMake(maxW, CGFLOAT_MAX);
    return  [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:tmpDict context:nil].size;
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
        CGFloat vipX = CGRectGetMaxX(self.nameLabelFrame)+HWStatusCellContentViewSpaceW;
        CGFloat vipY = HWStatusCellBorderW;
        CGFloat vipW = 14;
        CGFloat vipH = nameH;
        self.vipViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    
    /** 时间*/
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelFrame)+HWStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:statues.created_at font:HWTimeLabelFont];
    
    self.timeLabelFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    /** 来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame)+HWStatusCellContentViewSpaceW;
    CGFloat sourceY = timeY;
    //<a href="http://app.weibo.com/t/feed/PBP2P" rel="nofollow">微博 weibo.com</a>
    CGSize sourceSize = [self sizeWithText:[NSString stringWithFormat:@"from %@",statues.source] font:HWTimeLabelFont];
    self.sourceLabelFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    /** 正文*/
    CGFloat contentX = HWStatusCellBorderW;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewFrame),CGRectGetMaxY(self.timeLabelFrame))+HWStatusCellBorderW;
    CGSize contentSize = [self sizeWithText:statues.text font:HWNameLabelFont maxW:KMainScreenWidth-2*HWStatusCellBorderW];
    self.contentLabelFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    /** 配图*/

    

  

    //设置高度
    self.cellHeight = MAX(CGRectGetMaxY(self.contentLabelFrame),CGRectGetMaxY(self.photoViewFrame))+HWStatusCellBorderW;
    self.originalViewFrame = CGRectMake(0, 0, KMainScreenWidth, self.cellHeight);

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
