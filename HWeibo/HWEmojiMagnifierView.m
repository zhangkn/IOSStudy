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

- (void)setEmotionModel:(HWEmotionModel *)emotionModel{
    _emotionModel = emotionModel;
    self.emojiMagnifierButton.emotionModel = emotionModel;
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
