//
//  UIView+wbFrame.h
//  weibo
//
//  Created by 王涛 on 2016/10/20.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (wbFrame)

//分类里面不能添加成员变量
//@property如果在分类里面，只会自动生成get，set方法的声明，但是没有方法的实现，同时也不会生成带下划线的成员属性
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end
