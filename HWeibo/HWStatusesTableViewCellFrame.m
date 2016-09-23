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
    /** 1.原创微博控件*/
    [self setupOriginalViewFrame:statues];    
    /*2. 计算转发微博的 frame*/
    [self setupRepostViewFrame:statues];
    /*3. 计算toolbar*/
    [self setupToolbarViewFrame:statues];
    //4.计算cell 高度
//    self.cellHeight = MAX(CGRectGetMaxY(self.originalViewFrame),CGRectGetMaxY(self.repostViewFrame))+HWStatusCellBorderW;
    self.cellHeight = CGRectGetMaxY(self.toolbarViewFrame)+HWStatusCellBorderW;


}

#pragma mark - 计算原创微博的frame
- (void)setupToolbarViewFrame:(HWStatuses*)statues{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = MAX(CGRectGetMaxY(self.originalViewFrame), CGRectGetMaxY(self.repostViewFrame))+1;//分割线效果
    CGFloat toolbarW = KMainScreenWidth;
    CGFloat toolbarH = 35;
    self.toolbarViewFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}
#pragma mark - 计算原创微博的frame
- (void)setupOriginalViewFrame:(HWStatuses*)statues{
    
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
    
    
    
    if (statues.pic_urls.count>0) {
        //        NSLog(@"%@",statues.pic_urls);
        //        计算配图frame
        CGFloat photoY = CGRectGetMaxY(self.contentLabelFrame)+HWStatusCellBorderW;
        //        CGFloat photoW = KMainScreenWidth - 2*HWStatusCellBorderW;
        CGFloat photoW = 100;
        CGFloat photoX = (KMainScreenWidth-photoW)*0.5;
        CGFloat photoH = 100;
        self.photoViewFrame = CGRectMake(photoX, photoY, photoW, photoH);
    }
    
    //原创微博的frame
    CGFloat tmpcellHeight = MAX(CGRectGetMaxY(self.contentLabelFrame),CGRectGetMaxY(self.photoViewFrame))+HWStatusCellBorderW;
    self.originalViewFrame = CGRectMake(0, 0, KMainScreenWidth, tmpcellHeight);
    
}
#pragma mark - 计算转发微博的frame
- (void)setupRepostViewFrame:(HWStatuses*)statues{
    if (statues.retweeted_status) {
        NSLog(@"%@",statues.retweeted_status.text);
        //转发微博的文本信息
        CGFloat retweetedContentX = HWStatusCellBorderW;
        CGFloat retweetedContentY =HWStatusCellBorderW;
        NSString *tmp = [NSString stringWithFormat:@"@%@:%@",statues.retweeted_status.user.name,statues.retweeted_status.text];
        CGSize retweetedContentSize = [self sizeWithText:tmp font:HWNameLabelFont maxW:KMainScreenWidth-2*HWStatusCellBorderW];
        self.repostContentLabelFrame = CGRectMake(retweetedContentX, retweetedContentY, retweetedContentSize.width, retweetedContentSize.height);
        //转发微博的配图信息
        
        if (statues.retweeted_status.pic_urls.count>0) {
            //        NSLog(@"%@",statues.pic_urls);
            //        计算配图frame
            CGFloat repostphotoY = CGRectGetMaxY(self.repostContentLabelFrame)+HWStatusCellBorderW;
            //        CGFloat photoW = KMainScreenWidth - 2*HWStatusCellBorderW;
            CGFloat repostphotoW = 100;
            CGFloat repostphotoX = (KMainScreenWidth-repostphotoW)*0.5;
            CGFloat repostphotoH = 100;
            self.repostPhotoViewFrame = CGRectMake(repostphotoX, repostphotoY, repostphotoW, repostphotoH);
        }
        //原创微博的frame
        CGFloat repostTmpcellHeight = MAX(CGRectGetMaxY(self.repostContentLabelFrame),CGRectGetMaxY(self.repostPhotoViewFrame))+HWStatusCellBorderW;
        CGFloat repostViewX = 0;
        CGFloat repostViewY = CGRectGetMaxY(self.originalViewFrame);
        self.repostViewFrame = CGRectMake(repostViewX, repostViewY, KMainScreenWidth, repostTmpcellHeight);
    }
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
