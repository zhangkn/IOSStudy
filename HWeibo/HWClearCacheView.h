//
//  HWClearCacheView.h
//  HWeibo
//
//  Created by devzkn on 24/11/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWClearCacheView;
@protocol HWClearCacheViewDelegate <NSObject>
@required
- (void) clearCacheViewDidClickConfirmButon:(HWClearCacheView*)clearCacheView;

@end

@interface HWClearCacheView : UIView

@property (nonatomic,assign) id<HWClearCacheViewDelegate> delegate;

@end
