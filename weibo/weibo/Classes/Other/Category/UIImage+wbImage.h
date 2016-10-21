//
//  UIImage+wbImage.h
//  weibo
//
//  Created by 王涛 on 2016/10/18.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (wbImage)

+(instancetype)imageWithOriginalName:(NSString *)imageName;
+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end
