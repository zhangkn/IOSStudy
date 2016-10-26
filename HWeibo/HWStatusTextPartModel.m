//
//  HWStatusTextPartModel.m
//  HWeibo
//
//  Created by devzkn on 26/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "HWStatusTextPartModel.h"
/**存储图文混排的时候，对微博文本信息进行分段的文字 */
@implementation HWStatusTextPartModel

- (void)setText:(NSString *)text{
    _text = text;
    NSString *emojiPattern = @"\\[[a-zA-Z\u4e00-\u9fa5]+\\]";
    self.isEmotion = [text isMatchedByRegex:emojiPattern];
}




+ (instancetype)statusTextPartModelWithText:(NSString *)text range:(NSRange)range isspecial:(BOOL)isspecial{
    return [[self alloc]initWithText:text range:range isspecial:isspecial];
}

- (instancetype)initWithText:(NSString *)text range:(NSRange)range isspecial:(BOOL)isspecial{
    HWStatusTextPartModel *model = [[HWStatusTextPartModel alloc]init];
    model.text = text;
    model.range = range;
    model.isspecial = isspecial;
    return model;
}

+ (NSMutableArray *)statusTextPartModelsWithSpecialPattern:(NSString*)specialPattern text:(NSString*)text{
    NSMutableArray *statusTextPartModels = [NSMutableArray arrayWithCapacity:11];
    //1.获取分块的文本信息数组
    [text enumerateStringsMatchedByRegex:specialPattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) {
            return ;
        }
        [statusTextPartModels addObject:[HWStatusTextPartModel statusTextPartModelWithText:*capturedStrings range:*capturedRanges isspecial:YES]];
    }];
    [text enumerateStringsSeparatedByRegex:specialPattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) {
            return ;//过滤掉长度为0 的文本块
        }
        [statusTextPartModels addObject:[HWStatusTextPartModel statusTextPartModelWithText:*capturedStrings range:*capturedRanges isspecial:NO]];
    }];
    
    //2.排序文本块模型数组，按照range进行排序
    statusTextPartModels = [NSMutableArray arrayWithArray:[statusTextPartModels sortedArrayUsingComparator:^NSComparisonResult(HWStatusTextPartModel *obj1, HWStatusTextPartModel *obj2) {
        //系统是从小到大进行排序的，根据NSComparisonResult进行排序
        if (obj1.range.location > obj2.range.location) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if (obj1.range.location < obj2.range.location) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }]];
    return statusTextPartModels;
}



@end
