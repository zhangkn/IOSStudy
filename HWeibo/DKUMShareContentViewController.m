//
//  DKUMShareContentViewController.m
//  DKUMSocialSdkDemo
//
//  Created by devzkn on 08/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "DKUMShareContentViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialUIManager.h"


@interface DKUMShareContentViewController ()

//@property (weak, nonatomic) IBOutlet UIView *contentBgView;


@end

@implementation DKUMShareContentViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self share:nil];
}

//点击分享按钮
- (void)share:(id)sender {
    //隐藏内容视图
    //    self.contentBgView.hidden = YES;
    __weak typeof(self) weakSelf = self;
    //显示分享面板 （自定义UI可以忽略）
    [UMSocialUIManager showShareMenuViewInView:nil sharePlatformSelectionBlock:^(UMSocialShareSelectionView *shareSelectionView, NSIndexPath *indexPath, UMSocialPlatformType platformType) {
        [weakSelf disMissShareMenuView];
        [weakSelf shareDataWithPlatform:platformType];//直接分享
        
    }];
}
- (void)disMissShareMenuView
{
    self.view.hidden = NO;
}
//创建分享内容对象
- (UMSocialMessageObject *)creatMessageObject:(BOOL)isText mediastyle:(int)mediastyle isUrl:(BOOL)isUrl
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString *title = @"友盟social";
    NSString *url = @"http://ios9quan.9quan.com.cn/www/wine/show/70488/37961/9502";//@"http://wsq.umeng.com";
    NSString *text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    UIImage *image = [UIImage imageNamed:@"icon"];
    if (isText) {
        //纯文本分享
        messageObject.text = text;
    }
    switch (mediastyle) {
        case 0:
            if (isUrl) {//创建网页分享内容对象
                UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:@"http://dev.umeng.com/images/tab2_1.png"];
                [shareObject setWebpageUrl:url];
                messageObject.shareObject = shareObject;
            }
            break;
        case 1:
        {
            //创建图片对象
            UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:image];
            [shareObject setShareImage:@"http://dev.umeng.com/images/tab2_1.png"];
            messageObject.shareObject = shareObject;
            
            //                //@discuss linkedin平台需要传入的图片是url，如果图片不是https的，linkedin的sdk会崩溃，需要在info.plist中加入
            //                    <key>NSAppTransportSecurity</key>
            //                    <dict>
            //                    <key>NSAllowsArbitraryLoads</key>
            //                    <true/>
            //                    </dict>
            
            //                NSString* img_url = @"http://bbs.umeng.com/data/attachment/forum/201609/14/113141r2jqq0pjlooj0753.jpg";
            //                //NSString* img_url = @"https://content.linkedin.com/content/dam/developer/global/en_US/site/img/ipad_getstarted.png";
            //                UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:img_url];
            //                [shareObject setShareImage:img_url];
            
            //                NSString* img_url = @"http://dev.umeng.com/images/tab2_1.png";//@"http://bbs.umeng.com/data/attachment/forum/201609/14/113141r2jqq0pjlooj0753.jpg";
            //                //NSString* img_url = @"https://content.linkedin.com/content/dam/developer/global/en_US/site/img/ipad_getstarted.png";
            //                UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:img_url];
            //                [shareObject setShareImage:img_url];
            //                messageObject.shareObject = shareObject;
            
        }
            break;
        case 2:
        {
            UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:text thumImage:[UIImage imageNamed:@"icon"]];
            [shareObject setVideoUrl:@"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html"];
            messageObject.shareObject = shareObject;
        }
            
            break;
        case 3:
        {
            UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:text thumImage:[UIImage imageNamed:@"icon"]];
            [shareObject setMusicUrl:@"http://music.huoxing.com/upload/20130330/1364651263157_1085.mp3"];
            messageObject.shareObject = shareObject;
        }
            
            break;
        default:
            break;
    }
    return messageObject;
}

//直接分享
- (void)shareDataWithPlatform:(UMSocialPlatformType)platformType
{
 //修改分享的类型
#warning
    UMSocialMessageObject *messageObject = [self creatMessageObject:YES mediastyle:0 isUrl:YES];
    //调用分享接口
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        
        
        
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        }
        else{
            if (error) {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            }
            else{
                message = [NSString stringWithFormat:@"分享失败"];
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
    
}




@end
