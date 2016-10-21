//
//  wbCover.m
//  weibo
//
//  Created by 王涛 on 2016/10/21.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbCover.h"

@implementation wbCover

+ (instancetype)show{
    wbCover *cover = [[wbCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    [wbKeyWindow addSubview:cover];
    
    return cover;
    
}

#pragma mark - 设置浅灰色蒙板
- (void)setDimBackground:(BOOL)dimBackground{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{        
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
    }
}


#pragma mark - 点击蒙板的时候做事情
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
    
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        [_delegate coverDidClickCover:self];
        
    }
    
}

@end
