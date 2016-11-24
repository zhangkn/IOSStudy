//
//  HLSettingCell.m
//  HisunLottery
//
//  Created by devzkn on 4/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLSettingCell.h"
#import "HLSettingArrowItemModel.h"
#import "HLSettingSwitchItemModel.h"
#import "HLSettingLabeltemModel.h"

@interface HLSettingCell ()

@property (nonatomic,strong) UISwitch *accessorySwitchView;
@property (nonatomic,strong) UIImageView *accessoryDisclosureIndicatorView;
//label 属性
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,weak) UIView *dividerView;//分隔线




@end

@implementation HLSettingCell

- (UIView *)dividerView{
    if (nil == _dividerView) {
        if (!IOS7) {
            UIView *tmpView = [[UIView alloc]init];
            [tmpView setAlpha:0.2];
            [tmpView setBackgroundColor:[UIColor blackColor]];
            _dividerView = tmpView;
            [self.contentView addSubview:_dividerView];
        }
    }
    return _dividerView;
}

- (UILabel *)label{
    if (nil == _label) {
        UILabel *tmpView = [[UILabel alloc]init];
        [tmpView setTextColor:[UIColor redColor]];
        [tmpView setTextAlignment:NSTextAlignmentRight];
        [tmpView setBounds:CGRectMake(0, 0, 100, 44)];

        _label = tmpView;
    }
    return _label;
}

- (UIImageView *)accessoryDisclosureIndicatorView{
    if (nil == _accessoryDisclosureIndicatorView) {
        UIImageView *tmpView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
        _accessoryDisclosureIndicatorView = tmpView;
    }
    return _accessoryDisclosureIndicatorView;
}


- (UISwitch *)accessorySwitchView{
    if (nil == _accessorySwitchView) {
        UISwitch *tmpView = [[UISwitch alloc]init];
        _accessorySwitchView = tmpView;
    }
    return _accessorySwitchView;
}

#pragma mark - 装配数据
- (void)setItemModel:(HLSettingItemModel *)itemModel{
    _itemModel = itemModel;
    //装配cell
    [self setUpData];
    //设置setAccessoryView
    [self settingAccessoryView];
    
}

//设置cell显示内容
- (void) setUpData{
    [self.textLabel setText:self.itemModel.title];
    [self.imageView setImage:self.itemModel.iconImage];
    [self.detailTextLabel setText:self.itemModel.subTitle];
}

/** 设置辅助试图*/
- (void) settingAccessoryView{
    if ([self.itemModel isKindOfClass: [HLSettingArrowItemModel class]]) {
        [self setAccessoryView:self.accessoryDisclosureIndicatorView];
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault]; 
    }else if ([self.itemModel isKindOfClass:[HLSettingSwitchItemModel class]]){
        [self setAccessoryView:self.accessorySwitchView];
        //selectionStyle
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else if ([self.itemModel isKindOfClass:[HLSettingLabeltemModel class]]){
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault];//恢复可以选择的默认状态
        HLSettingLabeltemModel *labelModel = (HLSettingLabeltemModel *)self.itemModel;
        [self.label setText:labelModel.text];
        [self  setAccessoryView:self.label];
        
    }else{
        [self setAccessoryView:nil];
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault];


    }
}

+ (instancetype)tableVieCellWithItemModel:(HLSettingItemModel *)model tableView:(UITableView *)tableView{
    HLSettingCell *cell = [self tableViewCellWithTableView:tableView];
    [cell setItemModel:model];
    return cell;
}

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableVIew{
    NSString *identifier = @"HLSettingCell";
    HLSettingCell *cell = [tableVIew dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[HLSettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - 适配代码
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置一次性属性(适配IOS6，IOS7)
        //设置背景视图
        [self setUpBG];
        //设置子视图
        [self setUpSubViews];
    }
    return self;
    
}

- (void)setUpBG{
    UIView * bGView = [[UIView alloc]init];
    [bGView setBackgroundColor:[UIColor whiteColor]];
    self.selectedBackgroundView = bGView;

    UIView * selectedBGView = [[UIView alloc]init];
    [selectedBGView setBackgroundColor:HWColor(237, 233, 218)];
    self.selectedBackgroundView = selectedBGView;
    
}

- (void)setUpSubViews{
    [self.textLabel setBackgroundColor:nil];
    [self.detailTextLabel setBackgroundColor:nil];

}

- (void)setFrame:(CGRect)frame{
    //拉伸iOS6系统的cell大小，以达到contentView 覆盖整个屏幕
    if (!IOS7) {
        frame.size.width += 20;
        frame.origin.x -= 10;
    }
    [super setFrame:frame];
}

/** 设置分隔线*/
- (void)layoutSubviews{
    [super layoutSubviews];
    if (IOS7) {
        return;
    }
    CGFloat dividerX = self.textLabel.frame.origin.x;
    CGFloat dividery = 0;
    CGFloat dividerW = self.contentView.bounds.size.width;
    CGFloat dividerH = 1;
    [self.dividerView setFrame:CGRectMake(dividerX, dividery, dividerW, dividerH)];

}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    [self.dividerView setHidden:(indexPath.row ==0)];
}



@end
