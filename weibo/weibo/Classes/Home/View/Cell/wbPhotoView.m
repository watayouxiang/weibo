//
//  wbPhotoView.m
//  weibo
//
//  Created by 王涛 on 2016/11/11.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbPhotoView.h"
#import "UIImageView+WebCache.h"
#import "wbPhoto.h"

@interface wbPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation wbPhotoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        //裁剪图片，超出控件的部分裁剪掉
        self.clipsToBounds = YES;
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        
        [self addSubview:gifView];
        _gifView = gifView;
        
    }
    return self;
}

#pragma mark - 重写photo赋值方法
- (void)setPhoto:(wbPhoto *)photo{
    _photo = photo;
    
    //赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //判断下是否显示gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
