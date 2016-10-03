//
//  HWEmotionTextView.m
//  HWeibo
//
//  Created by devzkn on 03/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmotionTextView.h"
#import "HWEmotionModel.h"

@implementation HWEmotionTextView

- (void)insertEmotions:(HWEmotionModel *)model{
    
    NSMutableAttributedString *str= [[NSMutableAttributedString alloc]init];
    NSMutableAttributedString *tmp = [HWEmotionModel emotionMutableAttributedStringWithModel:model font:self.font];//表情数据
    //2. 调用代理方法，通知自定义键盘即将文字
    NSRange range = self.selectedRange;
    //    - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
    if ([self.emotionTextViewDelegate respondsToSelector:@selector(emotionTextView:shouldChangeTextInRange:replacementText:)]) {
        BOOL  isShouldChange = [self.emotionTextViewDelegate emotionTextView:self shouldChangeTextInRange:range replacementText:[tmp string]];
        if (!isShouldChange) {
            return;//不执行插入
        }
    }
    //3.执行添加文字信息动作
    //合并数据
    [str appendAttributedString:self.attributedText];
    //    [str appendAttributedString:tmp];
    [str deleteCharactersInRange:self.selectedRange];//删除选中内容
    [str insertAttributedString:tmp atIndex:self.selectedRange.location];//插入到当前光标的位置
    NSRange strRange;
    strRange.length = str.length;
    strRange.location = 0;
    [str addAttribute:NSFontAttributeName value:self.font range:strRange];
    NSRange tmpSelectedRange = self.selectedRange;
    self.attributedText =  str;
    [self insertText:@""];//发出通知UITextViewTextDidChangeNotification
    //4.调整光标位置
    self.selectedRange = NSMakeRange(tmpSelectedRange.location+tmp.length, 0);/** the length of the selection range is always 0, indicating that the selection is actually an insertion point*///
    //        [self.textView insertText: [str string]];//UITextViewTextDidChangeNotification 此方法才会发出通知    
}

@end
