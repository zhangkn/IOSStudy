//
//  HWTabBar.h
//  HWeibo
//
//  Created by devzkn on 7/21/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWTabBar;
@protocol HWTabBarDelegate <UITabBarDelegate>

@optional
- (void) tabBarDidClickPlusButton:(HWTabBar*)tabBar;

@end

@interface HWTabBar : UITabBar

@property (nonatomic,weak) id<HWTabBarDelegate> delegate;


@end
