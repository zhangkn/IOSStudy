//
//  HWEmojiListView.m
//  HWeibo
//
//  Created by devzkn on 02/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmojiListView.h"
//#import "HWEmojiPageView.h"



@interface HWEmojiListView ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation HWEmojiListView

- (UIPageControl *)pageControl{
    if (nil == _pageControl) {
        UIPageControl *tmpView = [[UIPageControl alloc]init];
        _pageControl = tmpView;
        UIImage *selectedImage = [UIImage imageNamed:@"compose_keyboard_dot_selected"];
        UIImage *normalImage = [UIImage imageNamed:@"compose_keyboard_dot_normal"];

//        [tmpView setCurrentPageIndicatorTintColor:[UIColor colorWithPatternImage:selectedImage]];
//        [tmpView setPageIndicatorTintColor:[UIColor colorWithPatternImage:normalImage]];
        [tmpView setValue:normalImage forKey:@"pageImage"];
        [tmpView setValue:selectedImage forKey:@"currentPageImage"];
        tmpView.userInteractionEnabled = NO;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (UIScrollView *)scrollView{
    if (nil == _scrollView) {
        UIScrollView *tmpView = [[UIScrollView alloc]init];
        _scrollView = tmpView;
        tmpView.pagingEnabled = YES;
        tmpView.showsHorizontalScrollIndicator = NO;
        tmpView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 构建子控件
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    self.scrollView.delegate = self;
    self.pageControl.backgroundColor = [UIColor whiteColor];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    //计算frame
    self.pageControl.height = 44;
    self.pageControl.x = 0;
    self.pageControl.width = self.width;
    self.pageControl.y = self.height - self.pageControl.height;
    //计算scrollview
    self.scrollView.x =0;
    self.scrollView.width = self.width;
    self.scrollView.y = 0;
    self.scrollView.height = self.pageControl.y;
    
    self.scrollView.contentSize = CGSizeMake(self.pageControl.numberOfPages*self.scrollView.width, self.scrollView.height);
    
    for (int i = 0; i<self.scrollView.subviews.count; i++) {//设置了tmpView.showsHorizontalScrollIndicator = NO; //        tmpView.showsVerticalScrollIndicator = NO; 对应的UIimageView 将消息
        HWEmojiPageView *view = self.scrollView.subviews[i];
        view.x =i*self.scrollView.width;
        view.y = 0;
        view.width = self.scrollView.width;
        view.height = self.scrollView.height;
    }
}


- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    //装配数据 到子控件
    NSLog(@"%lu",(unsigned long)emotions.count);
    
    [self setupDataPageControl:emotions];
    [self setupDataScrollView:emotions];
    
}
- (void)setupDataScrollView:(NSArray*)emotions{
    //创建用于容纳表情的控件 //根据新的数据，重新布局HWEmojiPageView的子控件
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i<self.pageControl.numberOfPages; i++) {
        HWEmojiPageView *tmp  = [[HWEmojiPageView alloc]init];
        //设置 HWEmojiPageView 的模型数据
        NSRange range ;
        range.location = i*HWEmojiListViewScrollViewMaxEmojiCout;        
        range.length = HWEmojiListViewScrollViewMaxEmojiCout;
        if (i==self.pageControl.numberOfPages-1) {//最后一页
            range.length = emotions.count - range.location;
        }
        NSArray *tmpArray = [emotions subarrayWithRange:range];
        tmp.emotions = tmpArray;
        tmp.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:tmp];
    }
//    [self setNeedsDisplay];//重新计算HWEmojiPageView 的大小
    [self layoutSubviews];
    
}

- (void)setupDataPageControl:(NSArray*)emotions{
    CGFloat pageCout =(emotions.count+ HWEmojiListViewScrollViewMaxEmojiCout-1)/(HWEmojiListViewScrollViewMaxEmojiCout);
    self.pageControl.numberOfPages = pageCout;

}
#pragma mark - //UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage =  (int)(self.scrollView.contentOffset.x/self.scrollView.width+0.5);//四舍五入
//    //，当页数即将发生改变时 通知keyboard 进行tabbar按钮的切换
//    CGFloat width =self.scrollView.contentSize.width;
//    if ( (self.scrollView.contentOffset.x-width) > width*0.5) {
//        //通知代理对象进行按钮的切换到下一个按钮
//    }
    
}



@end
