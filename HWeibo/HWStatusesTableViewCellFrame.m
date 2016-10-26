//
//  HWStatusesTableViewCellFrame.m
//  HWeibo
//
//  Created by devzkn on 9/19/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWStatusesTableViewCellFrame.h"
#import "HWStatuePhotosView.h"



@implementation HWStatusesTableViewCellFrame


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
/** 目的 时刻保持frame的时刻更新  timeSize.width会改变，必须重写sourceLabelFrame */
- (CGRect)timeLabelFrame{
    /** 时间*/
    CGFloat timeX = self.nameLabelFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelFrame)+HWStatusCellBorderW;
    CGSize timeSize = [_statues.created_at sizeWithTextFont:HWTimeLabelFont];
    _timeLabelFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    return _timeLabelFrame;
}
- (CGRect)sourceLabelFrame{
    /** 来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame)+HWStatusCellContentViewSpaceW;
    CGFloat sourceY = self.timeLabelFrame.origin.y;
    //<a href="http://app.weibo.com/t/feed/PBP2P" rel="nofollow">微博 weibo.com</a>
    CGSize sourceSize = [[NSString stringWithFormat:@"from %@",_statues.source] sizeWithTextFont:HWTimeLabelFont];
    _sourceLabelFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    return _sourceLabelFrame;
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
    CGSize nameSize = [statues.user.name sizeWithTextFont:HWNameLabelFont];
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
    CGSize timeSize = [statues.created_at sizeWithTextFont:HWTimeLabelFont];
    
    self.timeLabelFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    /** 来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame)+HWStatusCellContentViewSpaceW;
    CGFloat sourceY = timeY;
    //<a href="http://app.weibo.com/t/feed/PBP2P" rel="nofollow">微博 weibo.com</a>
    CGSize sourceSize = [[NSString stringWithFormat:@"from %@",statues.source] sizeWithTextFont:HWTimeLabelFont];
    self.sourceLabelFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    /** 正文*/
    CGFloat contentX = HWStatusCellBorderW;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewFrame),CGRectGetMaxY(self.timeLabelFrame))+HWStatusCellBorderW;
    CGSize contentSize = [statues.attributedText boundingRectWithSize:CGSizeMake(KMainScreenWidth-2*HWStatusCellBorderW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.contentLabelFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    /** 配图*/
    if (statues.pic_urls.count>0) {
        //        计算配图frame
        CGFloat photoY = CGRectGetMaxY(self.contentLabelFrame)+HWStatusCellBorderW;
        CGSize photoSize = [HWStatuePhotosView sizeWithPicUrlsCount:statues.pic_urls.count];
        CGFloat photoW = photoSize.width;
        CGFloat photoX = HWStatusCellBorderW;
        CGFloat photoH = photoSize.height;
        self.photoViewsFrame = CGRectMake(photoX, photoY, photoW, photoH);
    }
    
    //原创微博的frame
    CGFloat tmpcellHeight = MAX(CGRectGetMaxY(self.contentLabelFrame),CGRectGetMaxY(self.photoViewsFrame))+HWStatusCellBorderW;
    self.originalViewFrame = CGRectMake(0, 0, KMainScreenWidth, tmpcellHeight);
    
}

#pragma mark - 计算转发微博的frame
- (void)setupRepostViewFrame:(HWStatuses*)statues{
    if (statues.retweeted_status) {
        NSLog(@"%@",statues.retweeted_status.text);
        //转发微博的文本信息
        CGFloat retweetedContentX = HWStatusCellBorderW;
        CGFloat retweetedContentY =HWStatusCellBorderW;
        NSAttributedString *tmp = statues.retweeted_status.attributedText;
//        CGSize retweetedContentSize = [tmp sizeWithFont:HWNameLabelFont maxW:KMainScreenWidth-2*HWStatusCellBorderW];
        CGSize retweetedContentSize = [tmp boundingRectWithSize:CGSizeMake(KMainScreenWidth-2*HWStatusCellBorderW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;//记得设置NSAttributedString的字体
        self.repostContentLabelFrame = CGRectMake(retweetedContentX, retweetedContentY, retweetedContentSize.width, retweetedContentSize.height);
        //转发微博的配图信息
        if (statues.retweeted_status.pic_urls.count>0) {
            //        计算配图frame
            CGFloat repostphotoY = CGRectGetMaxY(self.repostContentLabelFrame)+HWStatusCellBorderW;
            CGSize repostphotoSize = [HWStatuePhotosView sizeWithPicUrlsCount:statues.retweeted_status.pic_urls.count];
            CGFloat repostphotoW = repostphotoSize.width;
            CGFloat repostphotoX = HWStatusCellBorderW;
            CGFloat repostphotoH = repostphotoSize.height;
            self.repostPhotosViewFrame = CGRectMake(repostphotoX, repostphotoY, repostphotoW, repostphotoH);
        }
        //转发微博的frame
        CGFloat repostTmpcellHeight = MAX(CGRectGetMaxY(self.repostContentLabelFrame),CGRectGetMaxY(self.repostPhotosViewFrame))+HWStatusCellBorderW;
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
