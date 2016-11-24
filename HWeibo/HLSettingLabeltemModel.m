//
//  HLSettingLabeltemModel.m
//  HisunLottery
//
//  Created by devzkn on 4/29/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLSettingLabeltemModel.h"
#import "HLSaveTool.h"

@implementation HLSettingLabeltemModel

- (void)setText:(NSString *)text{
    _text =text;
    //存储数据
    [HLSaveTool setObject:self.text forKey:self.title];
}


- (void)setTitle:(NSString *)title{//一旦有了title，就存储text
    [super setTitle:title];
    //额外动作,获取text，并对text 进行存储
    self.text = [HLSaveTool objectForKey:title];//从偏好设置获取
}
@end
