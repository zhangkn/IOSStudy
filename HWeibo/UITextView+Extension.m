//
//  UITextView+Extension.m
//  HWeibo
//
//  Created by devzkn on 04/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)insertAttributedString:(NSAttributedString *)tmp{
    [self insertAttributedString:tmp attributedStringBlock:nil];
}

- (void)insertAttributedString:(NSAttributedString*)tmp attributedStringBlock:(void(^)(NSMutableAttributedString* attributedString))attributedStringBlock{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]init];
    
    [str appendAttributedString:self.attributedText];
    [str deleteCharactersInRange:self.selectedRange];//删除选中内容
    [str insertAttributedString:tmp atIndex:self.selectedRange.location];//插入到当前光标的位置
    
    NSRange tmpSelectedRange = self.selectedRange;
    //执行特定的代码
    if (attributedStringBlock) {
        attributedStringBlock(str);
    }
    self.attributedText =  str;
    //    [self insertText:@""];//发出通知UITextViewTextDidChangeNotification; 方案二： 重写attributedText的setter方法。
    //调整光标位置
    self.selectedRange = NSMakeRange(tmpSelectedRange.location+tmp.length, 0);/** the length of the selection range is always 0, indicating that the selection is actually an insertion point*///
    //        [self.textView insertText: [str string]];//UITextViewTextDidChangeNotification 此方法才会发出通知
}

- (void)deleteText{
  
    if (self.selectedRange.length>=1) {
        //删除当前选中的内容
        NSAttributedString *insertAttributedString =[[NSAttributedString alloc]initWithString:@""];
        [self insertAttributedString:insertAttributedString];
        return;
    }else{
        //判断删除的字符长度
        NSUInteger length = [self getlengthBeforeCursorChar];
        //删除光标之前的字符
        self.selectedRange = NSMakeRange(self.selectedRange.location-length, length);
        NSAttributedString *insertAttributedString =[[NSAttributedString alloc]initWithString:@""];
        [self insertAttributedString:insertAttributedString];
        
    }
    
}

- (NSUInteger)getlengthBeforeCursorChar{
    NSUInteger length = 1;
    //获取光标之前的两个长度，判断是否为emoji
    NSRange beforeSelectedrangeTwoLengthRange = NSMakeRange(self.selectedRange.location-2, 2);
    NSString * str = [[self.attributedText attributedSubstringFromRange:beforeSelectedrangeTwoLengthRange] string];
    if ([str isEmoji]) {
        length = 2;
    }
    return length;
}

@end
