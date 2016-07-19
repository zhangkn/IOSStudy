//
//  HWMeTableViewController.m
//  HWeibo
//
//  Created by devzkn on 6/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWMeTableViewController.h"
#import "HWTest1ViewController.h"

@interface HWMeTableViewController ()

@end

@implementation HWMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //设置右边按钮
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setting
{
    HWTest1ViewController *test1 = [[HWTest1ViewController alloc] init];
    test1.title = @"test1";
    [self.navigationController pushViewController:test1 animated:YES];
}



@end
