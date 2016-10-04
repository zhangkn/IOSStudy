//
//  HWPlaceholderTextView.m
//  HWeibo
//
//  Created by devzkn on 9/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWPlaceholderTextView.h"




@interface HWPlaceholderTextView ()

/** textView输入控件的占位label*/
@property (nonatomic,weak) UILabel *textViewPalceHolderLabel;


@end

@implementation HWPlaceholderTextView


- (void)setFont:(UIFont *)font{
    [super setFont:font];
    //保证字体的一致性
    self.textViewPalceHolderLabel.font = font;
}

- (void)setText:(NSString *)text{
    [super setText:text];
    //处理占位符是否隐藏
    [self textViewTextDidChangeNotification];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    //处理占位符是否隐藏
    [self textViewTextDidChangeNotification];
}


- (void)setTextViewPalceHolderColor:(UIColor *)textViewPalceHolderColor{
    _textViewPalceHolderColor = textViewPalceHolderColor;
    self.textViewPalceHolderLabel.textColor = textViewPalceHolderColor;
}

- (void)setHiddentextViewPalceHolder:(BOOL)hiddentextViewPalceHolder{
    _hiddentextViewPalceHolder = hiddentextViewPalceHolder;
    self.textViewPalceHolderLabel.hidden = hiddentextViewPalceHolder;
}

- (void)setTextViewPalceHolder:(NSString *)textViewPalceHolder{
    _textViewPalceHolder = [textViewPalceHolder copy];
    self.textViewPalceHolderLabel.text = textViewPalceHolder;
}

- (UILabel *)textViewPalceHolderLabel{
    if (nil == _textViewPalceHolderLabel) {
        UILabel *tmpView = [[UILabel alloc]init];
        _textViewPalceHolderLabel = tmpView;
        tmpView.textColor = [UIColor grayColor];//默认的占位符颜色
        [self addSubview:_textViewPalceHolderLabel];
    }
    return _textViewPalceHolderLabel;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.textViewPalceHolderLabel setNumberOfLines:0];
        self.alwaysBounceVertical =YES ;//设置弹簧效果－－垂直方向
        /*
         Notifications
         
         UITextViewTextDidBeginEditingNotification
         Notifies observers that an editing session began in a text view. The affected view is stored in the object parameter of the notification. The userInfo dictionary is not used.
         UITextViewTextDidChangeNotification
         Notifies observers that the text in a text view changed. The affected view is stored in the object parameter of the notification. The userInfo dictionary is not used.
         UITextViewTextDidEndEditingNotification
         Notifies observers that the editing session ended for a text view. The affected view is stored in the object parameter of the notification. The userInfo dictionary is not used.

         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChangeNotification) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;    
}
- (void)dealloc{
    //清除监听者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 控制占位符是否隐藏
- (void)textViewTextDidChangeNotification{
    NSString *text = self.text;
    if (text.length == 0 &&
        [text isEqualToString:@""]){
        self.hiddentextViewPalceHolder = NO;
    }else{
        self.hiddentextViewPalceHolder = YES;
    }
}


+(instancetype)placeholderTextView{
    return [[self alloc]init];
}

+ (instancetype)placeholderTextViewWithTextViewPalceHolder:(NSString *)textViewPalceHolder{
    HWPlaceholderTextView *tmp = [self placeholderTextView];
    tmp.textViewPalceHolderLabel.text = textViewPalceHolder;
    return tmp;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.textViewPalceHolderLabel.text sizeWithFont:self.textViewPalceHolderLabel.font maxW:self.width];
    self.textViewPalceHolderLabel.size = size;
    self.textViewPalceHolderLabel.x = 5;
    self.textViewPalceHolderLabel.y =5;
    
}







@end
