//
//  wbTabBarButton.m
//  weibo
//
//  Created by 王涛 on 2016/10/20.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbTabBarButton.h"
#import "wbBadgeView.h"

#define wbImageRatio 0.7

@interface wbTabBarButton ()

@property (nonatomic, weak) wbBadgeView *badgeView;

@end

@implementation wbTabBarButton

-(wbBadgeView *)badgeView{
    if (_badgeView == nil) {
        wbBadgeView *badge = [wbBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:badge];
        _badgeView = badge;
    }
    return _badgeView;
}

-(void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    //KVO：时刻监听一个对象的属性有没有改变
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 只要监听的属性一有新值，就会调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
   
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    self.badgeView.badgeValue = _item.badgeValue;
}

#pragma mark - 初始化Frame
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

#pragma mark - 布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * wbImageRatio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}

#pragma mark - 取消高亮
-(void)setHighlighted:(BOOL)highlighted{}


@end
