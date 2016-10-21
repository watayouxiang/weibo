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

+ (instancetype)imageWithStretchableName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    //图片的拉伸方式设置：中心点拉伸，类似安卓的点九图
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
