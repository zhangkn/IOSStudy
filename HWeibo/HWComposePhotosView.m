//
//  HWCoposePhotosView.m
//  HWeibo
//
//  Created by devzkn on 01/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWComposePhotosView.h"



@interface HWComposePhotosView ()

@property (nonatomic,weak) UIButton *addPhotoButton;

@end

@implementation HWComposePhotosView

- (UIButton *)addPhotoButton{
    if (nil == _addPhotoButton) {
        UIButton *tmpView = [[UIButton alloc]init];
        _addPhotoButton = tmpView;
        [tmpView setImage:[UIImage imageNamed:@"store_add"] forState:UIControlStateNormal];
        [tmpView addTarget:self action:@selector(clickAddPhotoButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addPhotoButton];
    }
    return _addPhotoButton;
}

- (void)clickAddPhotoButton{
    if ([self.delegate respondsToSelector:@selector(composePhotosViewDidClickAddPhoto:)]) {
        [self.delegate composePhotosViewDidClickAddPhoto:self];
    }
}

- (NSArray *)getphotos{
    NSMutableArray *tmp = [NSMutableArray array];
    for (UIImageView *obj in self.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            //根据图片的type 进行转换成date
            NSData *tmpdata =UIImageJPEGRepresentation(obj.image, 0.1);//5M 以内的图片
            [tmp addObject:tmpdata];
        }
    }
    return tmp;
}

- (BOOL)hasComposePhotos{
    return  [[self getphotos] count]>0;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    int maxclos = 3;
    CGFloat margin = 5;
    CGFloat w = (self.width - margin*(maxclos-1))/maxclos;
    CGFloat h = w;
    //计算子空间frame
    for (int i=1 ; i<self.subviews.count; i++) {
        UIImageView *tmp= nil;
        if ([self.subviews[i] isKindOfClass:[UIImageView class]]) {
          tmp = (UIImageView*)self.subviews[i];
        }else{
            break;
        }
        if (tmp == nil) {
            break;
        }
        //计算frame： 列数决定x,行数决定y
        int row = (i-1)/maxclos;
        int clo = (i-1)%maxclos;
        tmp.x = clo*(w+margin);
        tmp.y = row*(h+margin);
        tmp.width = w;
        tmp.height = h;
        
    }
    
    if (self.subviews.count>=10) {
        return;
    }
    //设置addButton的frame
    self.addPhotoButton.size = CGSizeMake(w, h);
    long tmprow = (self.subviews.count-1)/maxclos;
    long tmpclo = (self.subviews.count-1)%maxclos;
    self.addPhotoButton.x = tmpclo*( w+ margin);
    self.addPhotoButton.y = tmprow *(h +margin);
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置自己属性
        //构建子控件
        [self setupAddButton];
    }
    return self;
}



- (void)setupAddButton{
    self.addPhotoButton.hidden = YES;
    
}
/** 往视图增加图片*/
- (void)addPhoto:(UIImage *)image{
    if (self.subviews.count>= 10) {
        return;
    }
    if (self.subviews.count>=1 && self.subviews.count<=9) {
        self.addPhotoButton.hidden = NO;//显示添加图片按钮
    }else{
        self.addPhotoButton.hidden = YES;
    }
    UIImageView *tmp = [[UIImageView alloc]init];
    tmp.image = image;
    tmp.contentMode = UIViewContentModeScaleAspectFill;
    tmp.clipsToBounds = YES;
    [self addSubview:tmp];
}





@end
