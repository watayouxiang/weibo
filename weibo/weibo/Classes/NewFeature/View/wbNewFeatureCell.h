//
//  wbNewFeatureCell.h
//  weibo
//
//  Created by 王涛 on 2016/10/26.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wbNewFeatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

//判断是否是最后一页
-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end
