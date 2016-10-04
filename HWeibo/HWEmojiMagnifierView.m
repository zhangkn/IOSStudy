//
//  HWEmojiMagnifierView.m
//  HWeibo
//
//  Created by devzkn on 03/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWEmojiMagnifierView.h"
#import "NSString+Emoji.h"
#import "HWEmojiButton.h"
@interface HWEmojiMagnifierView ()

@property (weak, nonatomic) IBOutlet HWEmojiButton *emojiMagnifierButton;
@property (weak, nonatomic)  UIImageView *emojiMagnifierImageView;



@end

@implementation HWEmojiMagnifierView

- (void)showFormButton:(HWEmojiButton*)btn{
    self.centerX = btn.centerX;
    self.y = btn.centerY - self.height;
    //坐标系转换,从 btn.superview 转换到 WINDOWLast
    self.frame = [btn.superview convertRect:self.frame toView:WINDOWLast];
    //设置放大镜数据
    self.emojiMagnifierButton.emotionModel =btn.emotionModel;
    [WINDOWLast addSubview:self];
}



+ (instancetype)emojiMagnifierView{
    return [[NSBundle mainBundle]loadNibNamed:@"HWEmojiMagnifierView" owner:nil options:nil].lastObject;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.emojiMagnifierButton.titleLabel.font = [UIFont systemFontOfSize:39];
    
}



//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    
//  
//}

@end
