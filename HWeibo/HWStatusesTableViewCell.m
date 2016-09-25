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
@interface HWStatusesTableViewCell ()
/**1. 原创微博控件*/
@property (nonatomic,weak) UIView *originalView;
/** 头像*/
@property (nonatomic,weak) UIImageView *iconView;
/** 会员图标*/
@property (nonatomic,weak) UIImageView *vipView;
/** 配图*/
@property (nonatomic,weak) UIImageView *photoView;
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
@property (nonatomic,weak) UIImageView *repostPhotoView;
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

- (UIImageView *)repostPhotoView{
    if (nil == _repostPhotoView) {
        UIImageView *tmpView = [[UIImageView alloc]init];
        _repostPhotoView = tmpView;
        [self.repostView addSubview:_repostPhotoView];
    }
    return _repostPhotoView;
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

- (UIImageView *)iconView{
    if (nil == _iconView) {
        UIImageView *tmpView = [[UIImageView alloc]init];
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

- (UIImageView *)photoView{
    if (nil == _photoView) {
        UIImageView *tmpView = [[UIImageView alloc]init];
        _photoView = tmpView;
        [self.originalView addSubview:_photoView];
    }
    return _photoView;
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
        [self.originalView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)sourceLabel{
    if (nil == _sourceLabel) {
        UILabel *tmpView = [[UILabel alloc]init];
        _sourceLabel = tmpView;
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
    self.photoView.contentMode = UIViewContentModeScaleAspectFit;
}

/** 构建原创微博*/
- (void) setupRepostView{
    self.repostView.backgroundColor = [UIColor clearColor];
    self.repostContentLabel.font = HWNameLabelFont;
    self.repostPhotoView.contentMode =UIViewContentModeScaleAspectFit;
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
    NSURL *iconImageURL = [ NSURL URLWithString:_frameModel.statues.user.profile_image_url];
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
    [self.iconView sd_setImageWithURL:iconImageURL placeholderImage:placeholderImage];
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
        self.photoView.hidden = NO;
        self.photoView.frame = frameModel.photoViewFrame;
        UIImage *placeholderImage = [UIImage imageNamed:@"timeline_image_placeholder"];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:[frameModel.statues.pic_urls[0] thumbnail_pic]] placeholderImage:placeholderImage];
    }else{
        self.photoView.hidden = YES;
        self.photoView.frame = CGRectZero;
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
        self.repostPhotoView.hidden = NO;
        self.repostView.frame = frameModel.repostViewFrame;
        self.repostContentLabel.frame = frameModel.repostContentLabelFrame;
        NSString *tmp = [NSString stringWithFormat:@"@%@:%@",frameModel.statues.retweeted_status.user.name,frameModel.statues.retweeted_status.text];
        self.repostContentLabel.text = tmp;
        //转发微币的配图
        if (frameModel.statues.retweeted_status.pic_urls.count>0) {
            self.repostPhotoView.hidden = NO;
            self.repostPhotoView.frame = frameModel.repostPhotoViewFrame;
            UIImage *placeholderImage = [UIImage imageNamed:@"timeline_image_placeholder"];
            [self.repostPhotoView sd_setImageWithURL:[NSURL URLWithString:[frameModel.statues.retweeted_status.pic_urls[0] thumbnail_pic]] placeholderImage:placeholderImage];
        }else{
            self.repostPhotoView.hidden = YES;
            self.repostPhotoView.frame = CGRectZero;
        }
    }else{
        self.repostView.hidden = YES;
        self.repostContentLabel.hidden = YES;
        self.repostPhotoView.hidden = YES;
    }
}

@end
