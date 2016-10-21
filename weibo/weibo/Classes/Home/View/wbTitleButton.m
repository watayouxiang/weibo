//
//  wbTitleButton.m
//  weibo
//
//  Created by 王涛 on 2016/10/21.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbTitleButton.h"

@implementation wbTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage imageWithStretchableName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.currentImage == nil) return;
    
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}

#pragma mark - 重写set方法，重新计算尺寸
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}

#pragma mark - 重写set方法，重新计算尺寸
- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
