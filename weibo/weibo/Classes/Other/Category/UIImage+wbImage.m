//
//  UIImage+wbImage.m
//  weibo
//
//  Created by 王涛 on 2016/10/18.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "UIImage+wbImage.h"

@implementation UIImage (wbImage)

+(instancetype)imageWithOriginalName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
