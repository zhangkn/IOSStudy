//
//  HWDropDown.h
//  HWeibo
//
//  Created by devzkn on 7/20/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWDropDown;
@protocol HWDropDownDelagate <NSObject>
@optional
- (void)dropDownDismiss:(HWDropDown*)dropdown;
- (void)dropDownShow:(HWDropDown*)dropdown;
@end


@interface HWDropDown : UIView
/** 下拉菜单控件*/
@property (nonatomic,weak) UIView *contentView;
/** 内容控制器*/
@property (nonatomic,weak) UIViewController *contentViewController;
@property (nonatomic,weak) id<HWDropDownDelagate> delegate;




+(instancetype)nemu;
-(void)showFrom:(UIView*)view;
-(void)dismiss;


@end
