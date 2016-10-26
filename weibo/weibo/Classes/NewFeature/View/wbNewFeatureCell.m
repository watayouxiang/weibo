//
//  wbNewFeatureCell.m
//  weibo
//
//  Created by 王涛 on 2016/10/26.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbNewFeatureCell.h"
#import "wbTabBarController.h"

@interface wbNewFeatureCell ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) UIButton *startButton;

@end

@implementation wbNewFeatureCell

//判断是否是最后一页
-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count{
    if (indexPath.row == count - 1) {
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    }else{
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

-(UIButton *)shareButton{
    if (_shareButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
        
        _shareButton = btn;
    }
    return _shareButton;
}

- (UIButton *)startButton{
    if (_startButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:@"开始微博" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];

        _startButton = btn;
        
    }
    return _startButton;
}

//是否分享
-(void)share:(UIButton *)btn{
    btn.selected = !btn.isSelected;
}

//进入主界面
- (void)start{
    wbTabBarController *tabBarVc = [[wbTabBarController alloc] init];
    wbKeyWindow.rootViewController = tabBarVc;
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        _imageView = imageV;
        
        [self.contentView addSubview:imageV];
    }
    return _imageView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.7);
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
}

-(void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}

@end
