//
//  HWStatusesTableViewCell.m
//  HWeibo
//
//  Created by devzkn on 9/19/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWStatusesTableViewCell.h"
#import "HWStatuses.h"
#import "UIImageView+WebCache.h"
#import "HWPhoto.h"
#import "HWStatuesToolbar.h"
#import "HWStatuePhotosView.h"
#import "HWIconView.h"
@interface HWStatusesTableViewCell ()
/**1. 原创微博控件*/
@property (nonatomic,weak) UIView *originalView;
/** 头像*/
@property (nonatomic,weak) HWIconView *iconView;
/** 会员图标*/
@property (nonatomic,weak) UIImageView *vipView;
/** 配图*/
@property (nonatomic,weak) HWStatuePhotosView *photosView;
/** 昵称*/
@property (nonatomic,weak) UILabel *nameLabel;
/** 时间*/
@property (nonatomic,weak) UILabel *timeLabel;
/** 来源*/
@property (nonatomic,weak) UILabel *sourceLabel;
/** 正文*/
@property (nonatomic,weak) UILabel *contentLabel;

/**2. 转发微博控件 */
/** 转发微博整体*/
@property (nonatomic,weak) UIView *repostView;
/** 转发配图*/
@property (nonatomic,weak) HWStatuePhotosView *repostPhotosView;
/** 转发文本*/
@property (nonatomic,weak) UILabel *repostContentLabel;

/**3. 转发微博控件 */
/** 工具条微博整体*/
@property (nonatomic,weak) HWStatuesToolbar *toolbarView;


@end

@implementation HWStatusesTableViewCell

- (UIView *)toolbarView{
    if (nil == _toolbarView) {
        HWStatuesToolbar *tmpView = [[HWStatuesToolbar alloc]init];
        _toolbarView = tmpView;
        [self.contentView addSubview:_toolbarView];
    }
    return _toolbarView;
}

- (UIView *)repostView{
    if (nil == _repostView) {
        UIView *tmpView = [[UIView alloc]init];
        _repostView = tmpView;
        [self.contentView addSubview:_repostView];
    }
    return _repostView;
}

- (UILabel *)repostContentLabel{
    if (nil == _repostContentLabel) {
        UILabel *tmpView = [[UILabel alloc]init];
        _repostContentLabel = tmpView;
        _repostContentLabel.numberOfLines = 0;
        [self.repostView addSubview:_repostContentLabel];
    }
    return _repostContentLabel;
}

- (HWStatuePhotosView *)repostPhotosView{
    if (nil == _repostPhotosView) {
        HWStatuePhotosView *tmpView = [[HWStatuePhotosView alloc]init];
        _repostPhotosView = tmpView;
        [self.repostView addSubview:_repostPhotosView];
    }
    return _repostPhotosView;
}
/**懒加载原创微博控件 */
- (UIView *)originalView{
    if (nil == _originalView) {
        UIView *tmpView = [[UIView alloc]init];
        _originalView = tmpView;
        [self.contentView addSubview:_originalView];
    }
    return _originalView;
}

- (HWIconView *)iconView{
    if (nil == _iconView) {
        HWIconView *tmpView = [[HWIconView alloc]init];
        _iconView = tmpView;
        [self.originalView addSubview:_iconView];
    }
    return _iconView;
}

- (UIImageView *)vipView{
    if (nil == _vipView) {
        UIImageView *tmpView = [[UIImageView alloc]init];
        _vipView = tmpView;
        [self.originalView addSubview:_vipView];
    }
    return _vipView;
}

- (HWStatuePhotosView *)photosView{
    if (nil == _photosView) {
        HWStatuePhotosView *tmpView = [[HWStatuePhotosView alloc]init];
        _photosView = tmpView;
        [self.originalView addSubview:_photosView];
    }
    return _photosView;
}

- (UILabel *)nameLabel{
    if (nil == _nameLabel) {
        UILabel *tmpView = [[UILabel alloc]init];
        _nameLabel = tmpView;
        [self.originalView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (nil == _timeLabel) {
        UILabel *tmpView = [[UILabel alloc]init];
        _timeLabel = tmpView;
        [tmpView setTextColor:HWHWStatuesToolbarTextColor];
        [self.originalView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)sourceLabel{
    if (nil == _sourceLabel) {
        UILabel *tmpView = [[UILabel alloc]init];
        _sourceLabel = tmpView;
        [tmpView setTextColor:HWHWStatuesToolbarTextColor];
        [self.originalView addSubview:_sourceLabel];
    }
    return _sourceLabel;
}

- (UILabel *)contentLabel{
    if (nil == _contentLabel) {
        UILabel *tmpView = [[UILabel alloc]init];
        _contentLabel = tmpView;
        [tmpView setNumberOfLines:0];
        [self.originalView addSubview:_contentLabel];
    }
    return _contentLabel;
}

/** 目的 ： 让第一个cell与导航栏有固定的间距*/
- (void)setFrame:(CGRect)frame{
    frame.origin.y += HWStatusCellBorderW;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;//去掉选中效果
        //设置共性属性、初始化内部控件
        [self setupOriginalView];
        //初始化转发控件
        [self setupRepostView];
        //初始化工具条
        [self setuptoolbarView];
        
    }
    return self;
}

- (void) setuptoolbarView{
    [self.toolbarView setBackgroundColor:[UIColor whiteColor]];
}

- (void) setupOriginalView{
    // 初始化原创控件
//    [self originalView];
    self.originalView.backgroundColor = [UIColor whiteColor];
    [self iconView];
    self.nameLabel.font = HWNameLabelFont;
    [self.vipView setContentMode:UIViewContentModeCenter];
    self.timeLabel.font = HWTimeLabelFont;
    self.sourceLabel.font =HWTimeLabelFont;
    self.contentLabel.font = HWNameLabelFont;
//    self.photosView.contentMode = UIViewContentModeScaleAspectFit;
    self.photosView.backgroundColor = [UIColor whiteColor];
}

/** 构建原创微博*/
- (void) setupRepostView{
    self.repostView.backgroundColor = [UIColor clearColor];
    self.repostContentLabel.font = HWNameLabelFont;
//    self.repostPhotoView.contentMode =UIViewContentModeScaleAspectFit;
    self.repostPhotosView.backgroundColor = [UIColor whiteColor];
}

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"HWStatusesTableViewCell";
    HWStatusesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HWStatusesTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

+ (instancetype)tableVieCellWithFrameModel:(HWStatusesTableViewCellFrame *)frameModel tableView:(UITableView *)tableView{
    static NSString *identifier = @"HWStatusesTableViewCell";
    HWStatusesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HWStatusesTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.frameModel = frameModel;
    return cell;
}


- (void)setFrameModel:(HWStatusesTableViewCellFrame *)frameModel{
//    NSLog(@"%@",frameModel.statues.user);
    _frameModel = frameModel;
    //1.装配原创微博的数据、frame
    [self setupOriginalViewFrameAndData:frameModel];
    //2.装配转发微博的数据、frame
    [self setupRepostViewFrameAndData:frameModel];
    //3. 装配工具条
    [self setupToolbarViewFrameAndData:frameModel];

   
    
}

#pragma mark - 装配toolbar微博控件
- (void)setupToolbarViewFrameAndData:(HWStatusesTableViewCellFrame*) frameModel{
    self.toolbarView.frame = frameModel.toolbarViewFrame;
    self.toolbarView.statuses = frameModel.statues;
}
#pragma mark - 装配原创微博控件
- (void)setupOriginalViewFrameAndData:(HWStatusesTableViewCellFrame*) frameModel{
    //设置控件frame
    self.originalView.frame = frameModel.originalViewFrame;
    self.iconView.frame = frameModel.iconViewFrame;
    self.iconView.user = frameModel.statues.user;
    //设置会员图标
    if (frameModel.statues.user.VIP) {
        [self.vipView setHidden:NO];
        self.nameLabel.textColor = HWColor(227, 92, 37);
        self.vipView.frame = frameModel.vipViewFrame;
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%@",frameModel.statues.user.mbrank];
        [self.vipView setImage:[UIImage imageNamed:imageName]];
        NSLog(@"%@,%@",frameModel.statues.user,self.vipView);
        
    }else{
        self.vipView.frame = CGRectZero;
        [self.vipView setHidden:YES];
        self.nameLabel.textColor = HWColor(0, 0, 0);
    }
    //配图
    if (frameModel.statues.pic_urls.count>0) {
        self.photosView.hidden = NO;
        self.photosView.frame = frameModel.photoViewsFrame;
        self.photosView.pic_urls = frameModel.statues.pic_urls;
    }else{
        self.photosView.hidden = YES;
        self.photosView.frame = CGRectZero;
    }
    //昵称
    self.nameLabel.frame = frameModel.nameLabelFrame;
    self.nameLabel.text = frameModel.statues.user.name;
    //时间
    /** 由于时间的格式处理，重写了created_at 方法进行格式化处理，因此timeLabelFrame 的getter也需对应重写getter*/
    self.timeLabel.text = frameModel.statues.created_at;//调用getter，getter的值随时间的不一样，而变化.此时对应的timeLabelFrame 需要重新计算。
    self.timeLabel.frame = frameModel.timeLabelFrame;//
    
    self.sourceLabel.frame = frameModel.sourceLabelFrame;
    self.sourceLabel.text = frameModel.statues.source;
    // 正文
    self.contentLabel.frame = frameModel.contentLabelFrame;
    self.contentLabel.text = frameModel.statues.text;
}

#pragma mark - 装配转发微博控件
- (void)setupRepostViewFrameAndData:(HWStatusesTableViewCellFrame*) frameModel{
    if (frameModel.statues.retweeted_status) {
        self.repostView.hidden = NO;
        self.repostContentLabel.hidden = NO;
        self.repostPhotosView.hidden = NO;
        self.repostView.frame = frameModel.repostViewFrame;
        self.repostContentLabel.frame = frameModel.repostContentLabelFrame;
        NSString *tmp = [NSString stringWithFormat:@"@%@:%@",frameModel.statues.retweeted_status.user.name,frameModel.statues.retweeted_status.text];
        self.repostContentLabel.text = tmp;
        //转发微币的配图
        if (frameModel.statues.retweeted_status.pic_urls.count>0) {
            self.repostPhotosView.hidden = NO;
            self.repostPhotosView.frame = frameModel.repostPhotosViewFrame;
            self.repostPhotosView.pic_urls = frameModel.statues.retweeted_status.pic_urls;
        }else{
            self.repostPhotosView.hidden = YES;
            self.repostPhotosView.frame = CGRectZero;
        }
    }else{
        self.repostView.hidden = YES;
        self.repostContentLabel.hidden = YES;
        self.repostPhotosView.hidden = YES;
    }
}

@end
