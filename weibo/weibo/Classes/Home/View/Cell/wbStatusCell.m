//
//  wbStatusCell.m
//  weibo
//
//  Created by 王涛 on 2016/11/4.
//  Copyright © 2016年 wata. All rights reserved.
//

/*
 问题：
 1.cell的高度应该提前计算出来
 2.cell的高度必须要先计算出每个子控件的frame，才能确定
 3.如果在cell的setStatus方法计算子控件的位置，会比较耗性能
 
 解决:MVVM思想
 M:模型
 V:视图
 VM:视图模型（模型包装视图模型，模型+模型对应视图的frame）
 
 */

#import "wbStatusCell.h"
#import "wbOriginalView.h"
#import "wbRetweetView.h"
#import "wbStatusToolBar.h"
#import "wbStatusFrame.h"

@interface wbStatusCell ()

@property (nonatomic, weak) wbOriginalView *originalView;
@property (nonatomic, weak) wbRetweetView *retweetView ;
@property (nonatomic, weak)  wbStatusToolBar *toolBar;

@end

@implementation wbStatusCell

#pragma mark - 构造方法
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    wbStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

#pragma mark - 重写cell初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //添加所有子控件
        [self setupAllChildView];
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}

#pragma mark - 添加所有子控件
-(void)setupAllChildView{
    //原创微博
    wbOriginalView *originalView = [[wbOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    //转发微博
    wbRetweetView *retweetView = [[wbRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    //工具条
    wbStatusToolBar *toolBar = [[wbStatusToolBar alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
}

#pragma mark - 重写statusF的赋值方法
-(void)setStatusF:(wbStatusFrame *)statusF{
    _statusF = statusF;
    
    //设置原创微博frame
    _originalView.frame = statusF.originalViewFrame;
    //设置原创微博子控件的frame和data
    _originalView.statusF = statusF;
    
    //设置转发微博frame
    _retweetView.frame = statusF.retweetViewFrame;
    //设置转发微博子控件的frame和data
    _retweetView.statusF = statusF;
    
    //设置工具条frame
    _toolBar.frame = statusF.toolBarFrame;
}

@end
