//
//  wbRetweetView.m
//  weibo
//
//  Created by 王涛 on 2016/11/4.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbRetweetView.h"
#import "wbStatus.h"
#import "wbStatusFrame.h"

@interface wbRetweetView ()

//昵称
@property (nonatomic, weak) UILabel *nameView;
//正文
@property (nonatomic, weak) UILabel *textView;

@end

@implementation wbRetweetView

#pragma mark - 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
        
    }
    return self;
}

#pragma mark - 添加所有子控件
- (void)setUpAllChildView{
    
    //昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.textColor = [UIColor blueColor];
    nameView.font = wbNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    //正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = wbTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
}

#pragma mark - 重写statusF的赋值方法
- (void)setStatusF:(wbStatusFrame *)statusF{
    _statusF = statusF;
    
    //设置frame
    [self setupFrame];
    //设置data
    [self setupData];
    
}

-(void)setupData{
    wbStatus *status = _statusF.status;
    
    //昵称
    _nameView.text = status.retweetName;
    wbLog(@"--------%@",status.retweetName);
    
    //正文
    _textView.text = status.retweeted_status.text;
}

-(void)setupFrame{
    //昵称frame
    _nameView.frame = _statusF.retweetNameFrame;
    
    //正文frame
    _textView.frame = _statusF.retweetTextFrame;
}

@end
