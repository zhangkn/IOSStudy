//
//  Const.m  定义const 全局常量  ,保证只在一处定义，多处进行引用
//  HWeibo
//
//  Created by devzkn on 05/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//


//#define HWClientId @"647592779"//宏会在编译时，将所有引用宏变量的地方，进行值的替换，造成很多相同的临时字面量，浪费内存
NSString * const HWClientId = @"647592779";// 全局的const常量 代替 宏常量，节省内存空间。内存只有一份
//#define HWRedirectUri @"https://www.baidu.com"
//#define HWClientSecret @"713f7438c3dc731b87d8a9624e7e8ab9"

NSString * const HWRedirectUri = @"https://www.baidu.com";//确保HWRedirectUri 变量不能被修改
//#define HWClientSecret @"713f7438c3dc731b87d8a9624e7e8ab9"
NSString * const HWClientSecret = @"713f7438c3dc731b87d8a9624e7e8ab9";



BOOL const HWUAT = 1;
