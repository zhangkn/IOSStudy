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
@interface HWStatusesTableViewCell ()
/** 原创微博控件*/
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


@end

@implementation HWStatusesTableViewCell

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
        [self.originalView addSubview:_contentLabel];
    }
    return _contentLabel;
}




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置共性属性、初始化内部控件
        self.photoView.backgroundColor = [UIColor redColor];
    }
    return self;
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
    _frameModel = frameModel;
    //设置控件frame
    self.originalView.frame = frameModel.originalViewFrame;
    self.iconView.frame = frameModel.iconViewFrame;
    NSURL *iconImageURL = [ NSURL URLWithString:_frameModel.statues.user.profile_image_url];
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
    [self.iconView sd_setImageWithURL:iconImageURL placeholderImage:placeholderImage];
    //设置会员图标
    self.vipView.frame = frameModel.vipViewFrame;
    [self.vipView setImage:[UIImage imageNamed:@"common_icon_membership_level1"]];
    //配图
    self.photoView.frame = frameModel.photoViewFrame;
    //昵称
    self.nameLabel.frame = frameModel.nameLabelFrame;
    self.nameLabel.text = frameModel.statues.user.name;
    //时间
    self.timeLabel.frame = frameModel.timeLabelFrame;
    
    self.sourceLabel.frame = frameModel.sourceLabelFrame;
    // 正文
    self.contentLabel.frame = frameModel.contentLabelFrame;
    self.contentLabel.text = frameModel.statues.text;
    //装配数据
}

@end
