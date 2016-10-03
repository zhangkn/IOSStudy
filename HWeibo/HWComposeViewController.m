//
//  HWComposeViewController.m
//  HWeibo
//
//  Created by devzkn on 9/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWComposeViewController.h"
#import "HWAccountTool.h"
#import "HWEmotionTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "HWComposeToolBar.h"
#import "HWComposePhotosView.h"
#import "HWEmojiKeyboard.h"
#import "HWEmotionModel.h"

@interface HWComposeViewController ()<UITextViewDelegate,HWComposeToolBarDelegete,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HWComposePhotosViewDelegate,HWEmotionTextViewDelegate>
/** 输入控件*/
@property (nonatomic,weak) HWEmotionTextView *textView;
/** 发送按钮是否enabled*/
@property (nonatomic,assign) BOOL isSendComposeEnabled;

/** textView 是否有内容*/
@property (nonatomic,assign) BOOL isTextViewHasChar;
/** 用户是否选择了上传图片*/
@property (nonatomic,assign) BOOL hasComposePhotos;


/** HWComposeToolBar 工具条*/
@property (nonatomic,strong) HWComposeToolBar *composeToolBar;


/** 显示从相册选择的image或者拍照的照片 的视图*/
@property (nonatomic,strong) HWComposePhotosView *composePhotosView;


/** emojiKeyboard 表情键盘*/
@property (nonatomic,strong) HWEmojiKeyboard *emojiKeyboard;
@end

@implementation HWComposeViewController

- (HWEmojiKeyboard *)emojiKeyboard{
    if (nil == _emojiKeyboard) {
        HWEmojiKeyboard *tmpView = [[HWEmojiKeyboard alloc]init];
        _emojiKeyboard = tmpView;
        tmpView.width= self.textView.width;
        tmpView.height = 44+44+ ((tmpView.width-2*HWEmojiListViewScrollViewMargin)/HWEmojiListViewScrollViewMaxClos)*HWEmojiListViewScrollViewMaxRows;
//        tmpView.x = 0;
//        tmpView.y = self.view.height - tmpView.height;
    }
    return _emojiKeyboard;
}

- (HWComposePhotosView *)composePhotosView{
    if (nil == _composePhotosView) {
        HWComposePhotosView *tmp = [[HWComposePhotosView alloc]init];
        tmp.x = 10;
        tmp.y = 100;
        tmp.width = self.view.width - tmp.x*2;
        tmp.height = self.textView.height;
        _composePhotosView = tmp;
//        tmp.backgroundColor = HWRandomColor;
        [self.textView addSubview:_composePhotosView];
    }
    return _composePhotosView;
}

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
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didSelectedEmojiNofificationName:) name:HWdidSelectedEmojiNofificationName object:nil];
        [self.view addSubview:_composeToolBar];
    }
    return _composeToolBar;
}
#pragma mark - 根据将表情添加到textview

- (void)didSelectedEmojiNofificationName:(NSNotification*)notification{
    //1.获取要添加的文字
    HWEmotionModel *model= notification.userInfo[HWselectedEmojiModelKey];
    [self.textView insertEmotions:model];
    
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
        CGFloat tmp = 0;
        if (keyboardFrame.origin.y<= KMainScreenHeight) {
            tmp =keyboardFrame.origin.y ;
        }else{
            tmp = KMainScreenHeight;
        }
        weakSelf.composeToolBar.y = tmp- self.composeToolBar.height;
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
    //构建显示相册图片的视图
    [self setupComposePhotosView];
    //构建表情键盘
//    [self setupEmojiKeyboard];
}

- (void)setupEmojiKeyboard{
//    [self.emojiKeyboard setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.view endEditing:YES];
}

- (void)setupComposePhotosView{
    [self.composePhotosView setDelegate:self];
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

#pragma mark -  HWComposePhotosViewDelegate

- (void)composePhotosViewDidClickAddPhoto:(HWComposePhotosView *)composePhotosView{
    [self openUIImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
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
#warning weibo 官法是自定义 UIImagePickerController，若想获取图片资源，采用AssetsLibbrary.framework 进行获取所有的图片
- (void)processHWComposeToolBarButtonTypeComposeCamerabutton{
    
    [self openUIImagePickerController:UIImagePickerControllerSourceTypeCamera];
   
}

- (void)openUIImagePickerController:(UIImagePickerControllerSourceType)type{
    //是否支持
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return;
    }
    //控制器跳转
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.sourceType = type;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
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
    
    
    /** 
     
     (lldb) po info
     {
     UIImagePickerControllerMediaMetadata =     {
     DPIHeight = 72;
     DPIWidth = 72;
     Orientation = 6;
     "{Exif}" =         {
     ApertureValue = "2.27500704749987";
     BrightnessValue = "-2.184053190731416";
     ColorSpace = 1;
     DateTimeDigitized = "2016:10:01 16:51:39";
     DateTimeOriginal = "2016:10:01 16:51:39";
     ExposureBiasValue = 0;
     ExposureMode = 0;
     ExposureProgram = 2;
     ExposureTime = "0.05882352941176471";
     FNumber = "2.2";
     Flash = 24;
     FocalLenIn35mmFilm = 29;
     FocalLength = "4.15";
     ISOSpeedRatings =             (
     640
     );
     LensMake = Apple;
     LensModel = "iPhone 6s back camera 4.15mm f/2.2";
     LensSpecification =             (
     "4.15",
     "4.15",
     "2.2",
     "2.2"
     );
     MeteringMode = 5;
     PixelXDimension = 4032;
     PixelYDimension = 3024;
     SceneType = 1;
     SensingMethod = 2;
     ShutterSpeedValue = "4.059158207392653";
     SubjectArea =             (
     2015,
     1511,
     2217,
     1330
     );
     SubsecTimeDigitized = 268;
     SubsecTimeOriginal = 268;
     WhiteBalance = 0;
     };
     "{MakerApple}" =         {
     1 = 4;
     14 = 0;
     2 = <0d001000 36001200 19001f00 28003700 3300ae00 ee00fa00 e6001f01 2f012201 0d001100 39001200 19002100 2b003300 3100b600 ec00fe00 ea002001 2a011a01 0c001200 3d001300 1a002200 36004300 4400b400 da00f800 f3001e01 29010c01 0c001500 45001300 1b002200 28002200 1e002600 3f00e000 f0002201 24011001 0c001c00 48001300 1a002200 21001f00 24002400 5700d300 eb001001 1201f600 0c003c00 38001300 17001d00 37004b00 52004b00 6400ce00 08013a01 3c011e01 0c004e00 1e001200 14001500 43005900 5b002500 1d002f00 7b00d500 18010201 0d004200 17001100 13001300 4b005b00 46002d00 16001b00 1d002b00 4800a000 0e003200 13001200 13001600 4f005800 4a001c00 14001400 23002d00 34008a00 0f000e00 0d001000 13001b00 53005500 52004100 36002700 3f004000 59007d00 0e000c00 0d000f00 12002600 4b004100 3e004200 4a004900 63007900 7a007c00 0b000d00 0d000f00 12002d00 1a001200 14001b00 44007900 95009700 98007a00 0c000d00 0c000e00 0f004000 17001100 11004300 8a008f00 9b00aa00 bf00b100 0d000c00 0b000c00 0d006300 29001400 15007400 85007e00 84009300 ab00b100 0e000c00 0a000a00 0b008000 48003500 45007500 78006e00 74008800 91009a00 0e000a00 09000900 0a009300 56003e00 47006000 65005b00 62006c00 79008100>;
     20 = 4;
     3 =             {
     epoch = 0;
     flags = 1;
     timescale = 1000000000;
     value = 611403874140375;
     };
     4 = 1;
     5 = 76;
     6 = 71;
     7 = 1;
     8 =             (
     "-0.1083837598562241",
     "-0.2783985435962677",
     "-0.9513330459594727"
     );
     9 = 4371;
     };
     "{TIFF}" =         {
     DateTime = "2016:10:01 16:51:39";
     Make = Apple;
     Model = "iPhone 6s";
     ResolutionUnit = 2;
     Software = "10.0.1";
     XResolution = 72;
     YResolution = 72;
     };
     };
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x17009db50> size {3024, 4032} orientation 3 scale 1.000000";
     }
     */
    //1. 显示图片到self.textView 上面
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.composePhotosView addPhoto:image];
    //2.处理发送按钮状态
    self.hasComposePhotos = [self.composePhotosView hasComposePhotos];
    [self processSendComposeButtonState];
    //3.dismissViewControllerAnimated
    [picker dismissViewControllerAnimated:YES completion:nil];

    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/** 选择相册*/
- (void)processHWComposeToolBarButtonTypeComposeToolbarPictureButton{
    [self openUIImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)processHWComposeToolBarButtonTypeComposeTrendbutton{
    
}
- (void)processHWComposeToolBarButtonTypeComposeMentionbutton{
    
}
- (void)processHWComposeToolBarButtonTypeComposeKeyboardbutton{
    //展示系统键盘
    self.emojiKeyboard.hidden = YES;
    self.textView.inputView = nil;
    //使键盘生效代码
    [self.textView endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];        
    });
}
- (void)processHWComposeToolBarButtonTypeComposeEmoticonbutton{
    //展示表情键盘
    self.emojiKeyboard.hidden = NO;
    self.textView.inputView = self.emojiKeyboard;
    //使键盘生效代码
    [self.textView endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
    
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //Dragging 的时候关闭键盘
    [self.view endEditing:YES];
}

#pragma mark - HWEmotionTextViewDelegate

- (BOOL)emotionTextView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return  [self textView:textView shouldChangeTextInRange:range replacementText:text];
}
    



#pragma mark - UITextViewDelegate
///** 改变composePhotosView的位置 */
//- (void)textViewDidChange:(UITextView *)textView{
//   
//}

/** 此方法只有用户点击return才可以触发*/
- (void)textViewDidEndEditing:(UITextView *)textView{
    [self.textView resignFirstResponder];
}

/** 控制字数、以及自动增加textView 的height*/
/** 
 The current selection range. If the length of the range is 0, range reflects the current insertion point. If the user presses the Delete key, the length of the range is 1 and an empty string object replaces that single character.
 */
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
    //1.控制发送按钮状态
    [self processSendComposeButtonState:strText replacementText:text];
    
    //2.控制composePhotosView的位置
   
    NSLog(@"打印字数＝＝%lu",(unsigned long)textView.text.length );
    double numLines = textView.contentSize.height/textView.font.lineHeight;
    NSLog(@"numlines = %f", numLines);
    // 计算出长宽1
    CGSize size = [[strText stringByAppendingString:text] sizeWithFont:self.textView.font maxW:textView.frame.size.width-10];
    CGFloat margin = size.height +textView.font.lineHeight*2;
    if (self.composePhotosView.y - margin <= 0 ) {
        self.composePhotosView.y = margin;
    }
    
    
    
    if ([text isEqualToString:@""]) {
        return YES;
    }
    
    //3. 控制字数
    int nTotalHasText = [self convertToInt:strText];// 原来字符串的字符个数
    // 计算新字符串的字符个数
    int nTotalToLoadText = [self convertToInt:text];
    
    /** 按键盘的return按钮，textview 失去焦点*/
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return false;
    }
    else if(nTotalHasText >= 1000 && nTotalToLoadText > 0)    {//控制字数为60
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
    if (self.isTextViewHasChar || self.hasComposePhotos) {//此条件是： 根据多个控件是否有内容进行判断。
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



- (HWEmotionTextView *)textView{
    if (nil == _textView) {
        NSString *textViewPalceHolder =  @"What's on your mind?";
        HWEmotionTextView *tmpView = [HWEmotionTextView placeholderTextViewWithTextViewPalceHolder:textViewPalceHolder];
        _textView = tmpView;
        tmpView.frame = self.view.bounds;
        tmpView.font = HWTextViewFont;
        tmpView.emotionTextViewDelegate = self;
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
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"access_token"]=[HWAccountTool account].access_token;
    if (self.textView.text.length ==0 || [self.textView.text isEqualToString:@""]) {
        paramters[@"status"]= @"share pictures for test，Please disregard/ignore the  message！";
    }else{
        paramters[@"status"]= [self.textView.text stringByAppendingString:@"\r\n---test app，Please ignore the  message!"];
    }
    //    3.发送请求
    if (self.isTextViewHasChar && !self.hasComposePhotos) {
        NSString *strUrl = @"https://api.weibo.com/2/statuses/update.json";
        [self updateJsonWithUrl:strUrl paramters:paramters mgr:mgr];
    }else{
        NSString *strUrl = @"https://upload.api.weibo.com/2/statuses/upload.json";
        [self uploadJsonWithUrl:strUrl paramters:paramters mgr:mgr];
    }
   
    //4. dismissViewControllerAnimated
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)updateJsonWithUrl:(NSString*)strUrl paramters:(NSDictionary*)paramters mgr:(AFHTTPRequestOperationManager*)mgr{
        [mgr POST:strUrl parameters:paramters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            [MBProgressHUD showSuccess:@"send"];
            //切换窗口的根控制器
//            [[UIApplication sharedApplication].keyWindow switchRootViewController];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD showError:@"failed"];
        }];
    
}

- (void)uploadJsonWithUrl:(NSString*)strUrl paramters:(NSDictionary*)paramters mgr:(AFHTTPRequestOperationManager*)mgr{
    NSArray *datas =[self.composePhotosView getphotos];
    [mgr POST:strUrl parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //处理文件上传
        /**
         pic	true	binary	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
         请求必须用POST方式提交，并且注意采用multipart/form-data编码方式；
         目前支持一张图片
         */
        [formData appendPartWithFileData:datas.lastObject name:@"pic" fileName:@"test.jpg" mimeType:@"multipart/form-data"];
        NSLog(@"%lu",(unsigned long)datas.lastObject);
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"send success"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"failed"];
        NSLog(@"%@",error);
    }];
}

@end
