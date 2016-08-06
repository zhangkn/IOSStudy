//
//  HWNewFeatureViewController.m
//  HWeibo
//
//  Created by devzkn on 7/22/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWNewFeatureViewController.h"
#import "HWTabBarController.h"
#define HWNewFeatureCount 4

@interface HWNewFeatureViewController () <UIScrollViewDelegate>

@property(nonatomic,weak) UIPageControl *pageControl;

@end

@implementation HWNewFeatureViewController
/**
 使用initWithContentsOfFile可以优先选择3x图像，而不是2x图像。
 NSString *path = [[NSBundle mainBundle] pathForResource:@"smallcat" ofType:@"png"];
 UIImage *image = [[UIImage alloc]initWithContentsOfFile:path];
 在ipone5 s、iphone6和iphone6 plus都是优先加载@3x的图片，如果没有@3x的图片，就优先加载@2x的图片
 
 这个方法
 [UIImage imageNamed:@"smallcat"]
 iphone5s和iphone6优先加载@2x的图片，iphone6 plus是加载@3x的图片。
 */
- (void)loadView{
    [super loadView];
    self.view.backgroundColor=HWRandomColor;
    //创建scrollView 来显示所有新特性的图片
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.contentSize= CGSizeMake(scrollView.width*HWNewFeatureCount, 0);
    [self.view addSubview:scrollView];
    //添加UIImageView
    for (int i = 0; i<HWNewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.size = scrollView.size;
        imageView.x= scrollView.width*i;
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        [imageView setImage:[UIImage imageNamed:imageName]];
        [scrollView addSubview:imageView];
        //如果是最后一个imageView,就添加其他控件内容
        if (i==HWNewFeatureCount-1) {
            [self setupLastImageView:imageView];
        }
    }
    //设置scrollview的其他属性
    scrollView.bounces = NO;//去除弹簧效果
    scrollView.pagingEnabled = YES;//paging 分页
    scrollView.showsHorizontalScrollIndicator = NO;//去掉水平方向的滚动条
    //设置分页控件
    UIPageControl *pageControl = [[UIPageControl alloc]init];
//    pageControl.userInteractionEnabled = NO;//去掉交互功能//也可去掉高度、宽度达到失去交互功能
    pageControl.numberOfPages = HWNewFeatureCount;
    pageControl.currentPageIndicatorTintColor = HWColor(253, 98, 42);
    pageControl.pageIndicatorTintColor= HWColor(189, 189,189);
    pageControl.centerX = scrollView.width*0.5;
    pageControl.centerY = scrollView.height-50;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}
#pragma mark - 关联pageControl、UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageIndex =scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage = (int)(pageIndex+0.5);//四舍五入
}

#pragma mark - 创建最后一个ImageView的其他控件内容
- (void)setupLastImageView:(UIImageView *)imageView{
    imageView.userInteractionEnabled =YES;
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.width =100;
    shareButton.height =30;
    shareButton.centerY = imageView.height*0.65;
    shareButton.centerX = imageView.width*0.5;
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [imageView addSubview:shareButton];
    
    //设置开始微博
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [startButton setTitle:@"开启微博" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(clickStartButton:) forControlEvents:UIControlEventTouchUpInside];
    startButton.size=startButton.currentBackgroundImage.size;
    startButton.centerX = imageView.width*0.5;
    startButton.centerY = imageView.height*0.75;
    [imageView addSubview:startButton];
}
- (void)clickShareButton:(UIButton*)button{
    button.selected = !button.isSelected;
}
#pragma mark - 开启微博
- (void)clickStartButton:(UIButton*)button{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[HWTabBarController alloc]init];

}

@end
