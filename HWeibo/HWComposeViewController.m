//
//  HWComposeViewController.m
//  HWeibo
//
//  Created by devzkn on 9/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWComposeViewController.h"
#import "HWAccountTool.h"
#define HWTextViewFont  [UIFont systemFontOfSize:13]

@interface HWComposeViewController ()<UITextViewDelegate>
/** 输入控件*/
@property (nonatomic,weak) UITextView *textView;
/** textView输入控件的占位label*/
@property (nonatomic,weak) UILabel *textViewPalceHolderLabel;


@end

@implementation HWComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置发布微博控制器的导航栏
    [self setupNavigationItem];
    //设置输入控件
    [self.textView setDelegate:self];
    [self.textView becomeFirstResponder];
    self.textViewPalceHolderLabel.font =HWTextViewFont;

}
#pragma mark - UITextViewDelegate

//- (void)textViewDidChangeSelection:(UITextView *)textView
//{
//    
//}
//
///** 动态计算textView 的高度*/
//- (void)textViewDidChange:(UITextView *)textView{
//    NSLog(@"打印字数＝＝%lu",(unsigned long)textView.text.length );
//    int numLines = textView.contentSize.height/textView.font.lineHeight;
//    NSLog(@"numlines = %i", numLines);
////    // 计算出长宽
////    CGSize size = [self.textView.text sizeWithFont:self.textView.font maxW:self.textView.frame.size.width];
////    CGRect rect = self.textView.frame;
////    rect.size.height = size.height + 15;
////    self.textView.frame = rect;
//}


- (void)textViewDidEndEditing:(UITextView *)textView{
    [self.textView resignFirstResponder];
}

/** 控制字数、以及自动增加textView 的height*/
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *strText = textView.text;//替换前的文字
    NSLog(@"------- text: %@    strText:%@   range.length: %lu   location: %lu ",text,strText,(unsigned long)range.length,range.location);
    
    if (strText.length == 0 &&
        [text isEqualToString:@""])
        self.textViewPalceHolderLabel.hidden = NO;
    else if (strText.length == 1 &&             [text isEqualToString:@""]){//处理删除键的情况
        self.textViewPalceHolderLabel.hidden = NO;
    }else
        self.textViewPalceHolderLabel.hidden = YES;
    
    if ([text isEqualToString:@""]) {
        return YES;
    }
    
    // 控制字数
    int nTotalHasText = [self convertToInt:strText];// 原来字符串的字符个数
    // 计算新字符串的字符个数
    int nTotalToLoadText = [self convertToInt:text];
    
    /** 按键盘的return按钮，textview 失去焦点*/
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return false;
    }
    else if(nTotalHasText >= 10000 && nTotalToLoadText > 0)    {//控制字数为60
        return false;
    }
    return YES;
    
}
/** 计算字符串中NSUnicodeStringEncoding 编码的字符个数*/
-  (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength;
    
}


#pragma mark - 设置输入控件

- (UILabel *)textViewPalceHolderLabel{
    if (nil == _textViewPalceHolderLabel) {
        UILabel *tmpView = [[UILabel alloc]init];
        _textViewPalceHolderLabel = tmpView;
        tmpView.textColor = [UIColor grayColor];
        tmpView.text = @"What's on your mind?";
        CGSize size = [tmpView.text sizeWithFont:tmpView.font];
        tmpView.size = size;
        tmpView.x = 5;
        tmpView.y =5;
        [self.textView addSubview:_textViewPalceHolderLabel];
    }
    return _textViewPalceHolderLabel;
}

- (UITextView *)textView{
    if (nil == _textView) {
        UITextView *tmpView = [[UITextView alloc]init];
        _textView = tmpView;
        tmpView.frame = self.view.bounds;
        [self.view addSubview:_textView];
    }
    return _textView;
}





/** 设置导航栏控件*/
- (void)setupNavigationItem{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelCompose)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendCompose)];
    self.navigationItem.rightBarButtonItem.enabled= NO;
    //设置标题视图
    [self setupNavigationItemTitleView];
}




#pragma mark 设置标题视图
-(void) setupNavigationItemTitleView{
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.width = 200;
    titleLable.height = 44;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.numberOfLines = 0;
    //设置 titleLable 的 NSMutableAttributedString -- 创建带有属性的字符串
    NSString *statuesName = [HWAccountTool account].name;
    NSString *strNewWeibo = @"new Weibo";
    NSString *titleStr = [NSString stringWithFormat:@"%@\n%@",strNewWeibo,statuesName];
    //设置new Weibo字符串属性
    NSRange range = [titleStr rangeOfString:strNewWeibo];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:13];//加粗字体
    dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    [attStr addAttributes:dic range:range];
    //设置微博昵称的字体颜色
    NSRange statuesNameRange = [titleStr rangeOfString:statuesName];
    NSMutableDictionary *dicName = [NSMutableDictionary dictionary];
    dicName[NSForegroundColorAttributeName] = [UIColor grayColor];
    /** NSShadowAttributeName 的使用*/
//    NSShadow *shadow = [[NSShadow alloc]init];
//    shadow.shadowColor = [UIColor yellowColor];
//    shadow.shadowOffset = CGSizeMake(5, 5);//必须设置，采用阴影效果
//    dicName[NSShadowAttributeName] = shadow;
    dicName[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [attStr addAttributes:dicName range:statuesNameRange];
    //    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:statuesNameRange];
    titleLable.attributedText =  attStr;
    self.navigationItem.titleView = titleLable;
}


#pragma mark - 取消发布

- (void)cancelCompose{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 发布
- (void)sendCompose{
    
    
}


@end
