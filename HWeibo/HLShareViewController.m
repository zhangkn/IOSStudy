//
//  HLShareViewController.m
//  HisunLottery
//
//  Created by devzkn on 4/30/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLShareViewController.h"
#import "HLSettingItemGroupModel.h"
#import "HLSettingArrowItemModel.h"
#import <MessageUI/MessageUI.h>

#import <UMSocialCore/UMSocialCore.h>
#import "DKUMShareContentViewController.h"

@interface HLShareViewController ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@end

@implementation HLShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup0];
    
}

- (void)addGroup0{
    //        1.弱引用成员变量或者控制器本事，防止block的循环引用
    __weak HLShareViewController *share = self;
    HLSettingItemGroupModel *group = [[HLSettingItemGroupModel alloc]init];
    HLSettingArrowItemModel *sinaItem = [HLSettingArrowItemModel itemModelWithTitle:@"新浪分享" icon:@"WeiboSina" destVCClass:nil];
    //新浪分享
    [sinaItem setOptionBlock:^{        
//        [UMSocialSnsService presentSnsIconSheetView:share
//                                             appKey:@"57249011e0f55a7e6e000cec"
//                                          shareText:@"你要分享的文字---kevin"
//                                         shareImage:[UIImage imageNamed:@"about_logo"]
//                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
//                                           delegate:share];
//        return ;
        
//        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:share completion:^(UMSocialResponseEntity *response){
//            if (response.responseCode == UMSResponseCodeSuccess) {
//                NSLog(@"分享成功！");
//            }
//        }];
        
        DKUMShareContentViewController *shareVc = [[DKUMShareContentViewController alloc] init];
        shareVc.title = @"分享";
        shareVc.tabBarItem.image = [UIImage imageNamed:@"UMS_share"];
        [self.navigationController pushViewController:shareVc animated:YES];
//        UINavigationController *shareNavi = [[UINavigationController alloc] initWithRootViewController:shareVc];
        
        
        
        
    }];
    HLSettingArrowItemModel *smsItem = [HLSettingArrowItemModel itemModelWithTitle:@"短信分享" icon:@"SmsShare" destVCClass:nil];
    //短信分享
    [smsItem setOptionBlock:^{
        //方式一:不能指定短信内容，不能自动回到原应用
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://188740548"]];
        //方式二 :MessageUI框架－－modal方法进行控制器间的切换
        MFMessageComposeViewController *vc= [[MFMessageComposeViewController alloc]init];
        // 设置短信内容
        vc.body = @"lydia,中心藏之， 何以忘之";
        // 设置收件人列表
        vc.recipients = @[@"1887405", @"487"];
        // 设置代理
        vc.messageComposeDelegate = share;
        // 显示控制器
        if (vc) {
            [share presentViewController:vc animated:YES completion:nil];//真机调试
        }
    
    }];
    HLSettingArrowItemModel *mailItem = [HLSettingArrowItemModel itemModelWithTitle:@"邮件分享" icon:@"MailShare" destVCClass:nil];
    //邮件分享
    [mailItem setOptionBlock:^{
        //1）方法一：用自带的邮件客户端--缺点：发完邮件后不会自动返回原界面
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto://zhang_kn@icloud.com"]];
        
        if (![MFMailComposeViewController canSendMail]) {//whether the current device is able to send email.
            return ;
        }
        //2）方法二： MFMailComposeViewController
        MFMailComposeViewController *mailVC =[[MFMailComposeViewController alloc]init];
        //设置邮件
        [mailVC setSubject:@"邮件主题:test:---------"];
        //设置邮件内容
        [mailVC setMessageBody:@"邮件内容: test------" isHTML:NO];
        //设置收件人列表
        [mailVC setToRecipients:@[@"zang_kn@icloud.com",@"hang_kn@hisuntech.com"]];
        //设置抄送列表
        [mailVC setCcRecipients:@[@"84924492@qq.com",@"hang_kn@hisuntech.com"]];
        //设置密送列表
        [mailVC setBccRecipients:@[@"94934863@qq.com",@"90977255@qq.com"]];
        //添加附件--Adds the specified data as an attachment to the message.
        UIImage *image = [UIImage imageNamed:@"lxh_beicui.png"];
        NSData *date = UIImagePNGRepresentation(image);//Returns the data for the specified image in PNG format
        /**
         The MIME type of the specified data. (For example, the MIME type for a JPEG image is image/jpeg.) For a list of valid MIME types, see http://www.iana.org/assignments/media-types/. This parameter must not be nil.
         */
        [mailVC addAttachmentData:date mimeType:@"image/png" fileName:@"lxh_beicui.png"];
        //设置代理
        [mailVC setMailComposeDelegate:share];
        [share presentViewController:mailVC animated:YES completion:nil];

    }];

    group.items = @[sinaItem,smsItem,mailItem];
    [self.dataList addObject:group];
}



#pragma mark - MFMessageComposeViewControllerDelegate 监听didFinishWithResult,进行关闭短信界面
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    /**
     enum MessageComposeResult {
     MessageComposeResultCancelled,
     MessageComposeResultSent,
     MessageComposeResultFailed
     };
     */
    [controller dismissViewControllerAnimated:YES completion:^{
        switch (result) {
            case MessageComposeResultCancelled:
                NSLog(@"%@",@"发送取消");
                break;
            case MessageComposeResultFailed:
                NSLog(@"%@",@"发送失败");
                break;
            case MessageComposeResultSent:
                NSLog(@"%@",@"发送成功");
                break;
            }
    }];
}
#pragma mark - MFMailComposeViewControllerDelegate 监听didFinishWithResult,进行关闭邮件界面
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    /*enum MFMailComposeResult {
        MFMailComposeResultCancelled,
        MFMailComposeResultSaved,
        MFMailComposeResultSent,
        MFMailComposeResultFailed
    };*/
    [controller dismissViewControllerAnimated:YES completion:^{
        switch (result) {
            case MFMailComposeResultCancelled:
                NSLog(@"%@",@"发送取消");
                break;
            case MFMailComposeResultFailed:
                NSLog(@"%@",@"发送失败");
                break;
            case MFMailComposeResultSent:
                NSLog(@"%@",@"发送成功");
                break;
            case MFMailComposeResultSaved:
                NSLog(@"%@",@"MFMailComposeResultSaved");//发送取消,并选择了save Draft
                break;
        }
    }];
    
}


- (void)dealloc{
    NSLog(@"%s",__func__);
}


#pragma mark - UMSocialUIDelegate 监听didFinishWithResult,进行关闭邮件界面   过时
/** http://dev.umeng.com/social/ios/detail-share*/
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
//    NSLog(@"%s",__func__);
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}





@end
