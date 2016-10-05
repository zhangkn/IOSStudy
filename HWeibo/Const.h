//
//  Const.h  ,只要引用此.h 文件，即可食用本头文件extern的全局变量
//  HWeibo
//
//  Created by devzkn on 05/10/2016.
//  Copyright © 2016 hisun. All rights reserved.

//声明需要全局常量，避免多处声明一样的全局常量
//
/** UIKIT_EXTERN NSNotificationName const UIKeyboardWillChangeFrameNotification  NS_AVAILABLE_IOS(5_0) __TVOS_PROHIBITED;   向系统底层API靠近
 
 UIKIT_EXTERN NSString *const UIKeyboardCenterBeginUserInfoKey   NS_DEPRECATED_IOS(2_0, 3_2) __TVOS_PROHIBITED;
*/
#import <Foundation/Foundation.h>

/** 即访问其他类定义的全局常量 HWClientId */
extern NSString * const HWClientId ; //声明全局常量变量（引用某个常量，来避免多处定义同一个全局变量，导致重复定义错误）通常是在定义全局常量的以外的地方（其他类），使用引用声明。

extern NSString * const HWRedirectUri ;
extern NSString * const HWClientSecret ;

extern BOOL const HWUAT;


