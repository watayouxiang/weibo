//
//  wbTabBar.m
//  weibo
//
//  Created by 王涛 on 2016/10/18.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbTabBar.h"
#import "wbTabBarButton.h"

@interface wbTabBar ()

@property (nonatomic, weak) UIButton *plusButton;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation wbTabBar

-(NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

-(void)setItems:(NSArray *)items{
    _items = items;
    
    for (UITabBarItem *item in _items) {
        wbTabBarButton *btn = [wbTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.item = item;
        btn.tag = self.buttons.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        //默认选中第一个UITabBarItem
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        
        [self addSubview:btn];
        
        [self.buttons addObject:btn];
    }
    
}

#pragma mark - 选中UITabBarItem时调用
-(void)btnClick:(UIButton *)button{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    //通知tabBarViewController切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}

-(UIButton *)plusButton{
    if (_plusButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        // 默认按钮的尺寸跟背景图片一样大
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        [btn sizeToFit];
        
        _plusButton = btn;
        
        [self addSubview:_plusButton];
    }
    return _plusButton;
}

#pragma mark - 布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = h;
    
    int i = 0;
    for (UIView *tabBarButton in self.subviews) {
        if (i == 2) {
            i = 3;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
}

@end









