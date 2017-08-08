//
//  HWSearchBar.m
//  HWeibo
//自定义搜索框
//  Created by devzkn on 7/20/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWSearchBar.h"

@implementation HWSearchBar

+(instancetype)searchBar{
    return [[self alloc]init];
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:12];
        self.placeholder = @"大家正在搜：张坤楠";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        //设置文本输入框的左视图
        UIImageView *searchIcon = [[UIImageView alloc]init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width =30;
        searchIcon.height =30;
        [searchIcon setContentMode:UIViewContentModeCenter];
        self.leftView= searchIcon;
        [self setLeftViewMode:UITextFieldViewModeUnlessEditing];
    }
    return self;
}
@end
