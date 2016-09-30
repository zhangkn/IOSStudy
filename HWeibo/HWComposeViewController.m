//
//  HWComposeViewController.m
//  HWeibo
//
//  Created by devzkn on 9/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWComposeViewController.h"
#import "HWAccountTool.h"
#import "HWPlaceholderTextView.h"

@interface HWComposeViewController ()<UITextViewDelegate>
/** 输入控件*/
@property (nonatomic,weak) HWPlaceholderTextView *textView;



@end

@implementation HWComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置发布微博控制器的导航栏
    [self setupNavigationItem];
    //设置输入控件
    [self.textView setDelegate:self];
    [self.textView becomeFirstResponder];

}
#pragma mark - UITextViewDelegate


- (void)textViewDidEndEditing:(UITextView *)textView{
    [self.textView resignFirstResponder];
}

/** 控制字数、以及自动增加textView 的height*/
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *strText = textView.text;//替换前的文字
    /** 隐藏占位字符串的逻辑移到自定义textview内部实现*/
//    NSLog(@"------- text: %@    strText:%@   range.length: %lu   location: %lu ",text,strText,(unsigned long)range.length,range.location);
//    
//    if (strText.length == 0 &&
//        [text isEqualToString:@""])
//        self.textView.hiddentextViewPalceHolder = NO;
//    else if (strText.length == 1 &&             [text isEqualToString:@""]){//处理删除键的情况
//        self.textView.hiddentextViewPalceHolder = NO;
//    }else
//        self.textView.hiddentextViewPalceHolder = YES;
//    
//    if ([text isEqualToString:@""]) {
//        return YES;
//    }
    
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



- (HWPlaceholderTextView *)textView{
    if (nil == _textView) {
        NSString *textViewPalceHolder =  @"What's on your mind?";
        HWPlaceholderTextView *tmpView = [HWPlaceholderTextView placeholderTextViewWithTextViewPalceHolder:textViewPalceHolder];
        _textView = tmpView;
        tmpView.frame = self.view.bounds;
        tmpView.font = HWTextViewFont;
        tmpView.textViewPalceHolderColor = [UIColor grayColor];
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
