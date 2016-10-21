//
//  wbBadgeView.m
//  weibo
//
//  Created by 王涛 on 2016/10/20.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbBadgeView.h"

#define wbBadgeViewFont [UIFont systemFontOfSize:11]

@implementation wbBadgeView

-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    CGSize size = [badgeValue sizeWithFont:wbBadgeViewFont];
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
    
}

#pragma mark - 初始化Frame
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = wbBadgeViewFont;
        
        //默认badgeView的大小和背景图片一样
        //此时会自动调整到最合适的尺寸
        [self sizeToFit];
    }
    return self;
}

@end
