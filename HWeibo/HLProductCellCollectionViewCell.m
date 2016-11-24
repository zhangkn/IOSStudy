//
//  HLProductCellCollectionViewCell.m
//  HisunLottery
//
//  Created by devzkn on 4/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HLProductCellCollectionViewCell.h"
#import "HLProductModel.h"

@interface HLProductCellCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation HLProductCellCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.imageView.layer setCornerRadius:10];
    [self.imageView setClipsToBounds:YES];//subviews are confined to the bounds of the view.
//    [self.imageView.layer masksToBounds];// sublayers are clipped to the layer’s bounds. 
}

- (void)setProductModel:(HLProductModel *)productModel{
    _productModel = productModel;
    
    [self.imageView setImage:self.productModel.iconImage];
    [self.label setText:productModel.title];
}



@end
