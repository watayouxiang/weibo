//
//  wbStatusFrame.m
//  weibo
//
//  Created by 王涛 on 2016/11/4.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbStatusFrame.h"
#import "wbStatus.h"

@implementation wbStatusFrame

#pragma mark - 重写status的赋值方法
-(void)setStatus:(wbStatus *)status{
    _status = status;
    
    //计算原创微博frame
    [self setupOriginalViewFrame];
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    //计算转发微博frame
    if (status.retweeted_status) {//判断是否有转发微博
        [self setupRetweetViewFrame];
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    
    //计算工具条frame
    CGFloat toolBarX = 0;
    CGFloat toolBarW = wbScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);

    //计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
}

#pragma mark - 计算原创微博frame
- (void)setupOriginalViewFrame{
    //头像
    CGFloat imageX = wbStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + wbStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:wbNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + wbStatusCellMargin * 0.5;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    //时间（因为每次更新都需要重新计算时间的frame，所以这里不做计算，转到wbOriginalView中计算）
    //来源（因为时间的frame实时计算，而来源的frame是基于时间的frame计算的，所以也要放在到wbOriginalView中计算）
    
    //正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + wbStatusCellMargin;
    
    CGFloat textW = wbScreenW - 2 * wbStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:wbTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    //配图
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + wbStatusCellMargin;
    if (_status.pic_urls.count) {
        CGFloat photosX = wbStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + wbStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + wbStatusCellMargin;
    }
    
    //原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = wbScreenW;
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}

#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count{
    //获取总列数
    int cols = count == 4 ? 2 : 3;
    //获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * wbStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * wbStatusCellMargin;
    
    return CGSizeMake(w, h);
}

#pragma mark - 计算转发微博frame
- (void)setupRetweetViewFrame{
    //转发微博的用户昵称
    CGFloat nameX = wbStatusCellMargin;
    CGFloat nameY = nameX;
    CGSize nameSize = [_status.retweetName sizeWithFont:wbNameFont];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //转发微博的正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + wbStatusCellMargin;
    
    CGFloat textW = wbScreenW - 2 * wbStatusCellMargin;
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:wbTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    //转发微博的配图
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + wbStatusCellMargin;
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = wbStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + wbStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + wbStatusCellMargin;
    }
    
    //原创微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = wbScreenW;
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}

@end
