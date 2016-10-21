//
//  wbPopMenu.h
//  weibo
//
//  Created by 王涛 on 2016/10/21.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wbPopMenu : UIImageView

//内容视图
@property (nonatomic, weak) UIView *contentView;

+ (instancetype)showInRect:(CGRect)rect;//显示弹出菜单
+ (void)hide;//隐藏弹出菜单

@end
