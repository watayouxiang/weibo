//
//  wbOriginalView.m
//  weibo
//
//  Created by 王涛 on 2016/11/4.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbOriginalView.h"
#import "wbStatus.h"
#import "wbStatusFrame.h"

#import "UIImageView+WebCache.h"

@interface wbOriginalView ()

//头像
@property (nonatomic, weak) UIImageView *iconView;
//昵称
@property (nonatomic, weak) UILabel *nameView;
//vip
@property (nonatomic, weak) UIImageView *vipView;
//时间
@property (nonatomic, weak) UILabel *timeView;
//来源
@property (nonatomic, weak) UILabel *sourceView;
//正文
@property (nonatomic, weak) UILabel *textView;

@end

@implementation wbOriginalView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
        
    }
    return self;
}

#pragma mark - 添加所有子控件
- (void)setUpAllChildView {
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    //昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = wbNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    //vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    //时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = wbTimeFont;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    //来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = wbSourceFont;
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    //正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = wbTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
}

#pragma mark - 重写StatusF的赋值方法
- (void)setStatusF:(wbStatusFrame *)statusF{
    _statusF = statusF;
    
    //设置frame
    [self setupFrame];
    //设置data
    [self setupData];
    
}

- (void)setupData{
    wbStatus *status = _statusF.status;
    
    //头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    //vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    _vipView.image = image;
    
    //时间
    _timeView.text = status.created_at;
    
    //来源
    _sourceView.text = status.source;
    
    //正文
    _textView.text = status.text;
}

- (void)setupFrame{
    //头像
    _iconView.frame = _statusF.originalIconFrame;
    
    //昵称
    _nameView.frame = _statusF.originalNameFrame;
    
    //vip
    if (_statusF.status.user.vip) {//是vip
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }
    
    //时间
    _timeView.frame = _statusF.originalTimeFrame;
    
    //来源
    _sourceView.frame = _statusF.originalSourceFrame;
    
    //正文
    _textView.frame = _statusF.originalTextFrame;
}

@end
