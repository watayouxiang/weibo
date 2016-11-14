//
//  wbPhotosView.m
//  weibo
//
//  Created by 王涛 on 2016/11/11.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbPhotosView.h"
#import "wbPhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "wbPhotoView.h"

@implementation wbPhotosView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //添加9个子控件
        [self setUpAllChildView];
        
    }
    return self;
}

- (void)setUpAllChildView{
    for (int i = 0; i < 9; i++) {
        
        wbPhotoView *imageV = [[wbPhotoView alloc] init];
        imageV.tag = i;
        
        //添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        
        [self addSubview:imageV];
    }
}

#pragma mark - 点击图片时候调用
- (void)tap:(UITapGestureRecognizer *)tap{
    UIImageView *tapView = tap.view;
    
    //wbPhoto模型 -> MJPhoto模型
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (wbPhoto *photo in _pic_urls) {
        
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        
        //获取高清配图的url
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjPhoto.url = [NSURL URLWithString:urlStr];
        
        mjPhoto.index = i;
        mjPhoto.srcImageView = tapView;
        
        [arrM addObject:mjPhoto];
        i++;
    }
    
    //弹出图片浏览器
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    brower.photos = arrM;
    brower.currentPhotoIndex = tapView.tag;
    [brower show];
}

#pragma mark - 重写pic_urls的赋值方法
- (void)setPic_urls:(NSArray *)pic_urls{
    _pic_urls = pic_urls;
    
    //总的有九个wbPhotoView，根据cell的情况，设置显示或隐藏即可
    int count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        wbPhotoView *imageV = self.subviews[i];
        if (i < _pic_urls.count) {
            imageV.hidden = NO;
            wbPhoto *photo = _pic_urls[i];
            imageV.photo = photo;
        }else{
            imageV.hidden = YES;
        }
    }
}

#pragma mark - 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
    
    //计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
}

@end
