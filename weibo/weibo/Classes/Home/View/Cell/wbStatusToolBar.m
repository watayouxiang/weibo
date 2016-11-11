//
//  wbStatusToolBar.m
//  weibo
//
//  Created by 王涛 on 2016/11/4.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbStatusToolBar.h"
#import "wbStatus.h"

@interface wbStatusToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *divideVs;

@property (nonatomic, weak) UIButton *retweet;
@property (nonatomic, weak) UIButton *comment;
@property (nonatomic, weak) UIButton *unlike;

@end

@implementation wbStatusToolBar

- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)divideVs{
    if (_divideVs == nil) {
        
        _divideVs = [NSMutableArray array];
    }
    return _divideVs;
}

#pragma mark - 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];
        
        //添加所有子控件
        [self setUpAllChildView];
        
    }
    return self;
}

#pragma mark - 添加所有子控件
- (void)setUpAllChildView{
    //转发
    UIButton *retweet = [self setupOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweet = retweet;
    
    //评论
    UIButton *comment = [self setupOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
    
    //赞
    UIButton *unlike = [self setupOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _unlike = unlike;
    
    //垂直分割线
    for (int i = 0; i < 2; i++) {
        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideV];
        [self.divideVs addObject:divideV];
    }
}

- (UIButton *)setupOneButtonWithTitle:(NSString *)title image:(UIImage *)image{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //按钮frame
    NSUInteger count = self.btns.count;
    CGFloat w = wbScreenW / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < count ; i++) {
        UIButton *btn = self.btns[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    //分割线frame
    int i = 1;
    for (UIImageView *divide in self.divideVs) {
        UIButton *btn = self.btns[i];
        divide.x = btn.x;
        i++;
    }
}

#pragma mark - 重写status的赋值方法
-(void)setStatus:(wbStatus *)status{
    _status = status;
    
    //转发
    [self setBtn:_retweet title:status.reposts_count];
    
    //评论
    [self setBtn:_comment title:status.comments_count];
    
    //赞
    [self setBtn:_unlike title:status.attitudes_count];
}

- (void)setBtn:(UIButton *)btn title:(int)count{
    /**
     >10000
     12000   1.2w
     10100   1w
     */
    NSString *title = nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{
            title = [NSString stringWithFormat:@"%d",count];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

@end
















