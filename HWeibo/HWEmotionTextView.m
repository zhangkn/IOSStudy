//
//  HWEmotionTextView.m
//  HWeibo
//
//  Created by devzkn on 03/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmotionTextView.h"
#import "HWEmotionModel.h"
#import "HWEmotionTextAttachment.h"

@implementation HWEmotionTextView

- (NSString *)fullText{
    NSMutableString *tmp= [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        // 获取对应的attributedSubstring
        NSAttributedString *attributedSubstring = [self.attributedText attributedSubstringFromRange:range];
        //判断文字类型
        HWEmotionTextAttachment *attachment = (HWEmotionTextAttachment*)attrs[@"NSAttachment"];
        if (attachment) {
            [tmp appendString:[attachment getChs]];
        }else{
            [tmp appendString:[attributedSubstring string]];
        }
    }];
    return tmp;
}


- (void)insertEmotions:(HWEmotionModel *)model{
    
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
    weakSelf(weakSelf);
    [self insertAttributedString:tmp attributedStringBlock:^(NSMutableAttributedString *attributedString) {
        //执行特定代码  设置文字属性
        [attributedString addAttribute:NSFontAttributeName value:weakSelf.font range:NSMakeRange(0, attributedString.length)];
    }];
    //4.设置文字属性
//    [self setupAttributedTextAttribute];
  
}

- (void)setupAttributedTextAttribute{
    NSMutableAttributedString *str= [[NSMutableAttributedString alloc]init];
    [str appendAttributedString:self.attributedText];
    NSRange strRange;
    strRange.length = str.length;
    strRange.location = 0;
    [str addAttribute:NSFontAttributeName value:self.font range:strRange];
    self.attributedText = str;
}

@end
