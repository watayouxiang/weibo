//
//  wbPopMenu.m
//  weibo
//
//  Created by 王涛 on 2016/10/21.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbPopMenu.h"

@implementation wbPopMenu

+ (instancetype)showInRect:(CGRect)rect{
    
    wbPopMenu *menu = [[wbPopMenu alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
    
    [wbKeyWindow addSubview:menu];
    
    return menu;
}

+ (void)hide{
    for (UIView *popMenu in wbKeyWindow.subviews) {
        if ([popMenu isKindOfClass:self]) {
            [popMenu removeFromSuperview];
        }
    }
}

- (void)setContentView:(UIView *)contentView{

    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}

@end
