//
//  UITextView+Extension.h
//  HWeibo
//
//  Created by devzkn on 04/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
/** 往textview插入NSAttributedString*/
- (void)insertAttributedString:(NSAttributedString*)tmp;
/**  往textview插入NSAttributedString 的同时，执行特定的代码*/
- (void)insertAttributedString:(NSAttributedString*)tmp attributedStringBlock:(void(^)(NSMutableAttributedString* attributedString))attributedStringBlock;
/** 删除光标之前的文字 you can use     [self.textView deleteBackward]; */
- (void)deleteText;

@end
