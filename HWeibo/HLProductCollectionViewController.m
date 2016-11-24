//
//  HLProductCollectionViewController.m
//  HisunLottery
//
//  Created by devzkn on 4/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLProductCollectionViewController.h"
#import "HLProductModel.h"
#import "HLProductCellCollectionViewCell.h"

@interface HLProductCollectionViewController ()

@property (nonatomic,strong) NSArray *products;

@end

@implementation HLProductCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (NSArray *)products{
    if (nil == _products) {
        _products = [HLProductModel list];
    }
    return _products;
}


- (instancetype)init{
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    [collectionViewLayout setMinimumLineSpacing:10];//垂直间距
    [collectionViewLayout setMinimumInteritemSpacing:1];//水平间距
    [collectionViewLayout setItemSize:CGSizeMake(75, 75)];
    //设置分组内边距
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 0, 0, 0);
    [collectionViewLayout setSectionInset:(insets)];

    self = [super initWithCollectionViewLayout:collectionViewLayout];
    if (self) {
        //
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes  for use in creating new collection view cells.
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    UINib *nib = [UINib nibWithNibName:@"HLProductCellCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLProductCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    [cell setProductModel:self.products[indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取模型
    HLProductModel *model = self.products[indexPath.item];
    NSString *urlStr = [NSString stringWithFormat:@"%@://%@",model.customUrl,model.ID];
    NSURL *url = [NSURL URLWithString:urlStr];
    UIApplication *app = [UIApplication sharedApplication];
    if (![app canOpenURL:url]) {//2016-04-30 17:39:03.355 HisunLottery[932:417803] -canOpenURL: failed for URL: "newsapp://com.netease.news" - error: "This app is not allowed to query for scheme newsapp"
        url =[NSURL URLWithString:model.url];//跳转到appstore的URL
    }
    [app openURL:url];
}


@end
