//
//  HWMessageTableViewController.m
//  HWeibo
//
//  Created by devzkn on 6/27/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWMessageTableViewController.h"
#import "HWTest1ViewController.h"

@interface HWMessageTableViewController ()

@end

@implementation HWMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test@%d",indexPath.row];
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HWTest1ViewController *test1VC = [[HWTest1ViewController alloc]init];
    test1VC.title = @"test1";
    // 当test1控制器被push的时候，test1所在的tabbarcontroller的tabbar会自动隐藏
    // 当test1控制器被pop的时候，test1所在的tabbarcontroller的tabbar会自动显示
    [self.navigationController pushViewController:test1VC animated:YES];
}


@end
