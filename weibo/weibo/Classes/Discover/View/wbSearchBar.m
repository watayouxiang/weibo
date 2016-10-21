//
//  wbSearchBar.m
//  weibo
//
//  Created by 王涛 on 2016/10/21.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbSearchBar.h"

@implementation wbSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.font = [UIFont systemFontOfSize:13];
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        //设置左边的view
        //initWithImage:默认UIImageView的尺寸跟图片一样
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageV.width += 10;
        imageV.contentMode = UIViewContentModeCenter;
        self.leftView = imageV;
        
        //设置左边视图的模式
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
