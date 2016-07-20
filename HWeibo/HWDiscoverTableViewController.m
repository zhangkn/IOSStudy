//
//  HWDiscoverTableViewController.m
//  HWeibo
//
//  Created by devzkn on 6/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWDiscoverTableViewController.h"

@interface HWDiscoverTableViewController ()

@end

@implementation HWDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UISearchBar *searchBar = [[UISearchBar alloc]init];
    UITextField *searchBar = [[UITextField alloc]init];
    searchBar.width = 300;
    searchBar.height =30;
    searchBar.font = [UIFont systemFontOfSize:12];
    searchBar.placeholder = @"大家正在搜：霉霉侃爷撕逼";
    searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    //设置文本输入框的左视图
    UIImageView *searchIcon = [[UIImageView alloc]init];
    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    searchIcon.width =30;
    searchIcon.height =30;
    [searchIcon setContentMode:UIViewContentModeCenter];
    searchBar.leftView= searchIcon;
    [searchBar setLeftViewMode:UITextFieldViewModeUnlessEditing];

    self.navigationItem.titleView =searchBar;
}




@end
