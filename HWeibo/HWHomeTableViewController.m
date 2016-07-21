//
//  HWHomeTableViewController.m
//  HWeibo
//
//  Created by devzkn on 6/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWHomeTableViewController.h"
#import "HWDropDown.h"

@interface HWHomeTableViewController ()

@end

@implementation HWHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置左边按钮
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem barButtonItemWithTarget:self  Image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted" actionMethod:@selector(friendsearch)];
    //设置右边按钮
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem barButtonItemWithTarget:self  Image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted" actionMethod:@selector(pop)];
    //设置中间标题控件
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.height=30;
    titleButton.width=150;//文字长度＋图片长度
    UIImage *timelineMoreHighlightedIcon =[UIImage imageNamed:@"timeline_icon_more_highlighted"];
    [titleButton setImage:timelineMoreHighlightedIcon forState:UIControlStateNormal];
    [titleButton setTitle:@"HomePage" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置边距
    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, titleButton.width-timelineMoreHighlightedIcon.size.width, 0, 0)];
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,timelineMoreHighlightedIcon.size.width);
    //监听标题的点击
    [titleButton addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.titleView =titleButton;


}
#pragma mark - 点击标题
/**
 图片中不规则的方向是  ：不可拉伸的方向
 */
- (void)clickTitle:(UIButton*) titleButton{
    HWDropDown *dropDwonNemu= [HWDropDown nemu];
    //设置下拉框视图
    dropDwonNemu.contentView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 190, 217)];
    //显示下拉框
    [dropDwonNemu showFrom:titleButton];
    
}

- (void)pop{
    NSLog(@"%s",__func__);
}

- (void)friendsearch{
    NSLog(@"%s",__func__);
}


@end
