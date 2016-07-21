//
//  HWDiscoverTableViewController.m
//  HWeibo
//
//  Created by devzkn on 6/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWDiscoverTableViewController.h"
#import "HWSearchBar.h"

@interface HWDiscoverTableViewController ()

@end

@implementation HWDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UISearchBar *searchBar = [[UISearchBar alloc]init];
    HWSearchBar *searchBar = [HWSearchBar searchBar];
    searchBar.width =300;
    searchBar.height =30;
    self.navigationItem.titleView =searchBar;
}




@end
