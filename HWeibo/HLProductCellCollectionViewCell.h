//
//  HLProductCellCollectionViewCell.h
//  HisunLottery
//
//  Created by devzkn on 4/28/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLProductModel;
@interface HLProductCellCollectionViewCell : UICollectionViewCell

//自定义视图的现实的数据来源于模型，即使用模型装配自定义视图的显示内容
@property (nonatomic,strong)  HLProductModel *productModel;//视图对应的模型，是视图提供给外界的接口


@end
