//
//  wbStatusToolBar.m
//  weibo
//
//  Created by 王涛 on 2016/11/4.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbStatusToolBar.h"

@implementation wbStatusToolBar

#pragma mark - 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor orangeColor];
        
    }
    return self;
}

#pragma mark - 添加所有子控件
- (void)setUpAllChildView{
    
}

@end
