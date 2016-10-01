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
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "HWComposeToolBar.h"



@interface HWComposeViewController ()<UITextViewDelegate,HWComposeToolBarDelegete,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 输入控件*/
@property (nonatomic,weak) HWPlaceholderTextView *textView;
/** 发送按钮是否enabled*/
@property (nonatomic,assign) BOOL isSendComposeEnabled;

/** textView 是否有内容*/
@property (nonatomic,assign) BOOL isTextViewHasChar;

/** HWComposeToolBar 工具条*/
@property (nonatomic,strong) HWComposeToolBar *composeToolBar;

@end

@implementation HWComposeViewController

- (HWComposeToolBar *)composeToolBar{
    if (nil == _composeToolBar) {
        HWComposeToolBar *tmpView = [[HWComposeToolBar alloc]init];
        _composeToolBar = tmpView;
        tmpView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        tmpView.width = self.textView.width;
        tmpView.height = 44;
        //方法一： 工具条放于textView上面，工具条会随着键盘的弹出、隐藏
//        self.textView setInputView:<#(UIView * _Nullable)#>设置键盘
        //设置键盘上面的顶部的内容，会跟随键盘的弹出、隐藏。
//        self.textView.inputAccessoryView =_composeToolBar;
         //方法二： 工具条永远都在,并且在监听键盘的通知
        tmpView.x = 0;
        tmpView.y = self.view.height - tmpView.height;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [self.view addSubview:_composeToolBar];
    }
    return _composeToolBar;
}

#pragma mark - 根据键盘的frame设置工具条的frame
- (void)keyboardWillChangeFrameNotification:(NSNotification*)notification{
    /** 
     
     NSConcreteNotification 0x60800025da90 {name = UIKeyboardWillChangeFrameNotification; userInfo = {
     UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {320, 253}},//键盘最终的位置
     UIKeyboardAnimationDurationUserInfoKey = 0.4, //AnimationTime 动画的时间
     UIKeyboardAnimationCurveUserInfoKey = 7, //动画的执行节奏
     }}

//     */
    weakSelf(weakSelf);
    NSTimeInterval  keyboardAnimationDuration = [(NSNumber*)notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSTimeInterval  keyboardAnimationCurveUserInfoKey = [(NSNumber*)notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
     CGRect keyboardFrame = [(NSValue*)notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:(keyboardAnimationDuration) delay:0.0 options:keyboardAnimationCurveUserInfoKey animations:^{
        weakSelf.composeToolBar.y = keyboardFrame.origin.y- self.composeToolBar.height;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置发布微博控制器的导航栏
    [self setupNavigationItem];
    //设置输入控件
    [self setupTextView];
    //设置键盘顶部的内容：工具条
    [self  setupComposeToolBar];
}

- (void)setupComposeToolBar{
    
    self.composeToolBar.delegete = self;
}

- (void)setupTextView{
    [self.textView setDelegate:self];
    [self.textView becomeFirstResponder];
    self.isTextViewHasChar = self.textView.text.length>0;
    [self processSendComposeButtonState];
}

#pragma mark - HWComposeToolBarDelegete
/**处理工具条的按钮 */
- (void)composeToolBarDelegeteDidClickToolButton:(HWComposeToolBar *)composeToolBar clickToolButtonType:(HWComposeToolBarButtonType)clickToolButtonType{
    switch (clickToolButtonType) {
        case HWComposeToolBarButtonTypeComposeCamerabutton:
            [self processHWComposeToolBarButtonTypeComposeCamerabutton];
            break;
        case HWComposeToolBarButtonTypeComposeToolbarPictureButton:
            [self processHWComposeToolBarButtonTypeComposeToolbarPictureButton];
            break;
        case HWComposeToolBarButtonTypeComposeTrendbutton:
            [self processHWComposeToolBarButtonTypeComposeTrendbutton];
            break;
        case HWComposeToolBarButtonTypeComposeMentionbutton:
            [self processHWComposeToolBarButtonTypeComposeMentionbutton];
            break;
        case HWComposeToolBarButtonTypeComposeKeyboardbutton:
            [self processHWComposeToolBarButtonTypeComposeKeyboardbutton];
            break;
        case HWComposeToolBarButtonTypeComposeEmoticonbutton:
            [self processHWComposeToolBarButtonTypeComposeEmoticonbutton];
            break;
    }
    
}
#pragma mark - 处理工具条细节的辅助方法
/** 打开拍照控制器*/
- (void)processHWComposeToolBarButtonTypeComposeCamerabutton{
   
}

 #pragma mark - UIImagePickerControllerDelegate
// The picker does not dismiss itself; the client dismisses it in these callbacks.
// The delegate will receive one or the other, but not both, depending whether the user
// confirms or cancels.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    /** 
     
     po info
     {
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x600000283070> size {4288, 2848} orientation 0 scale 1.000000";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=106E99A1-4F6A-45A2-B320-B0AD4A8E8473&ext=JPG";
     }

     */
    NSLog(@"%@",info);
    //的到图片 显示到self.textView 上面
    [picker dismissViewControllerAnimated:YES completion:nil];

    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/** 选择相册*/
- (void)processHWComposeToolBarButtonTypeComposeToolbarPictureButton{
    
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
    
}
- (void)processHWComposeToolBarButtonTypeComposeTrendbutton{
    
}
- (void)processHWComposeToolBarButtonTypeComposeMentionbutton{
    
}
- (void)processHWComposeToolBarButtonTypeComposeKeyboardbutton{
    
}
- (void)processHWComposeToolBarButtonTypeComposeEmoticonbutton{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //Dragging 的时候关闭键盘
    [self.view endEditing:YES];
}


#pragma mark - UITextViewDelegate



/** 此方法只有用户点击return才可以触发*/
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
    //1.控制发送按钮
    [self processSendComposeButtonState:strText replacementText:text];
    
    if ([text isEqualToString:@""]) {
        return YES;
    }
    
    //2. 控制字数
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

/**控制发送按钮状态 */
- (BOOL)processSendComposeButtonState:(NSString* )strText replacementText:text{
    
    if (strText.length == 0 &&        [text isEqualToString:@""]){
        self.isTextViewHasChar=   NO;
    }else if (strText.length == 1 &&             [text isEqualToString:@""]){//处理删除键的情况
       self.isTextViewHasChar   =NO;
    }else{
       self.isTextViewHasChar  =YES;
    }
    [self processSendComposeButtonState];
    return self.isTextViewHasChar;
}
#pragma mark - 根据多个控件是否有内容进行控制发送按钮
- (void) processSendComposeButtonState{
    if (self.isTextViewHasChar) {//此条件是： 根据多个控件是否有内容进行判断。
        self.isSendComposeEnabled = YES;
    }else{
        self.isSendComposeEnabled = NO;

    }
    self.navigationItem.rightBarButtonItem.enabled = self.isSendComposeEnabled;
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
    
    NSString *statuesName = [HWAccountTool account].name;
    NSString *strNewWeibo = @"new Weibo";
    if (statuesName && ![statuesName isEqualToString:@""]) {
        [self setupNavigationItemTitleViewWithstrNewWeibo:strNewWeibo statuesName:statuesName];
    }else{
//        self.navigationItem.title = strNewWeibo;
        self.title = strNewWeibo;
    }
    
}

- (void)setupNavigationItemTitleViewWithstrNewWeibo:(NSString*)strNewWeibo statuesName:(NSString*)statuesName{
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.width = 200;
    titleLable.height = 44;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.numberOfLines = 0;
    //设置 titleLable 的 NSMutableAttributedString -- 创建带有属性的字符串
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
/** 
 https://api.weibo.com/2/statuses/update.json
 请求参数
 必选	类型及范围	说明
 access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
 status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 pic 	false	binary	微博的配图。  nsdata
 visible	false	int	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
 list_id	false	string	微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
 lat	false	float	纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
 long	false	float	经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
 annotations	false	string	元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
 rip	false	string	开发者上报的操作用户真实IP，形如：211.156.0.1。
 
 
 */
- (void)sendCompose{
    [self.textView resignFirstResponder];
    //1.请求管理器
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    [mgr setResponseSerializer:[AFJSONResponseSerializer serializer]];//afn 默认的解析器
    /** 可以修改源代码，来支持更多的ContentTypes
     self.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", nil];
     */
    //2.拼接请求参数
    NSString *strUrl = @"https://api.weibo.com/2/statuses/update.json";
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"access_token"]=[HWAccountTool account].access_token;
    paramters[@"status"]= self.textView.text;
//    paramters[@"grant_type"]= @"authorization_code";//请求的类型，填写authorization_code
//    paramters[@"code"]= code;//调用authorize获得的code值。
//    paramters[@"redirect_uri"]= HWRedirectUri;//	回调地址，需需与注册应用里的回调地址一致。
    //3.发送请求
    [mgr POST:strUrl parameters:paramters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"send"];
//        HWAccountModel *account = [HWAccountModel accountWithDictionary:responseObject];
//        //存储帐号信息
//        [HWAccountTool saveAccount:account];
        NSLog(@"succ sendCompose");
        //切换窗口的根控制器
//        [[UIApplication sharedApplication].keyWindow switchRootViewController];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"failed"];
    }];
    //4. dismissViewControllerAnimated
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
