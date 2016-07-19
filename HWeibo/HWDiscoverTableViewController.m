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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    UISearchBar *searchBar = [[UISearchBar alloc]init];
    UITextField *searchBar = [[UITextField alloc]init];
    searchBar.width = 300;
    searchBar.height =30;
    searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    self.navigationItem.titleView =searchBar;
}




@end
