//
//  wbHomeViewController.m
//  weibo
//
//  Created by 王涛 on 2016/10/20.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbHomeViewController.h"
#import "UIBarButtonItem+wbItem.h"

#import "wbTitleButton.h"
#import "wbCover.h"
#import "wbPopMenu.h"

#import "wbOneViewController.h"

#import "wbPhoto.h"
#import "wbUser.h"
#import "wbStatus.h"
#import "wbStatusFrame.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "wbStatusTool.h"
#import "wbUserTool.h"
#import "wbAccount.h"
#import "wbAccountTool.h"

#import "wbStatusCell.h"

@interface wbHomeViewController ()<wbCoverDelegate>

@property (nonatomic, weak) wbTitleButton *titleButton;
@property (nonatomic, strong) wbOneViewController *one;
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation wbHomeViewController

- (NSMutableArray *)statusFrames{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (wbOneViewController *)one{
    if (_one == nil) {
        _one = [[wbOneViewController alloc] init];
    }
    return _one;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView的背景色
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
    
    //设置导航栏
    [self setupNavigationBar];
    
    //下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    [self.tableView headerBeginRefreshing];
    
    //加载更多
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    //设置用户昵称
    [self setupUserName];
    
}

#pragma mark - 设置用户昵称
-(void)setupUserName{
    [wbUserTool userInfoWithSuccess:^(wbUser *user) {
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //将用户信息保存到偏好设置
        wbAccount *account = [wbAccountTool account];
        account.name = user.name;
        [wbAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 刷新最新的微博
- (void)refresh{
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
}

#pragma mark - 下拉刷新
-(void)loadNewStatus{
    NSString *sinceId = nil;
    if (self.statusFrames.count) {//有微博数据，才需要下拉刷新
        wbStatus *status = [self.statusFrames[0] status];
        sinceId = status.idstr;
    }
    
    [wbStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {        
        //提示刷新出来的微博条数
        [self showNewStatusCount:statuses.count];
        
        //结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        //wbStatus转wbStatusFrame
        NSMutableArray *statusFrames = [self statusesParserStatusFrames:statuses];
        
        //把最新的微博数插入到最前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 提示刷新出来的微博条数
-(void)showNewStatusCount:(NSInteger)count{
    if (count == 0) {
        return;
    }
    
    CGFloat h = 35;
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat w = self.view.width;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.text = [NSString stringWithFormat:@"最新微博数%ld",count];
    label.textColor = [UIColor whiteColor];
    [label setFont:[UIFont systemFontOfSize:15]];
    label.textAlignment = NSTextAlignmentCenter;
    
    //插入到navigationBar的下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        //下移
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            //还原
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}

#pragma mark - 加载更多
-(void)loadMoreStatus{
    NSString *maxIdStr = nil;
    if (self.statusFrames.count) {//有微博数据，才需要下拉刷新
        wbStatus *status = [[self.statusFrames lastObject] status];
        long long maxId = [status.idstr longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    [wbStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        //结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        //wbStatus转wbStatusFrame
        NSMutableArray *statusFrames = [self statusesParserStatusFrames:statuses];
        
        //把数组中的元素添加进去
        [self.statusFrames addObjectsFromArray:statusFrames];
        
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - wbStatus转wbStatusFrame
-(NSMutableArray *)statusesParserStatusFrames:(NSArray *)statuses{
    NSMutableArray *statusFrames = [NSMutableArray array];
    for (wbStatus *status in statuses) {
        wbStatusFrame *statusFrame = [[wbStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFrames addObject:statusFrame];
    }
    return statusFrames;
}

#pragma mark - 设置导航栏
-(void)setupNavigationBar{
    
    //leftBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    //rightBarButtonItem
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    //titleView
    wbTitleButton *titleButton = [wbTitleButton buttonWithType:UIButtonTypeCustom];
    self.titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
}

-(void)titleClick:(UIButton *)button{
    NSLog(@"%s", __func__);
    
    button.selected = !button.selected;
    
    //弹出蒙板
    wbCover *cover = [wbCover show];
    cover.delegate = self;
    
    
    //弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    wbPopMenu *menu = [wbPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
}

- (void)coverDidClickCover:(wbCover *)cover{
    [wbPopMenu hide];

    _titleButton.selected = NO;
}

-(void)friendsearch{
    NSLog(@"%s", __func__);
}

-(void)pop{
    NSLog(@"%s", __func__);
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //创建cell
    wbStatusCell *cell = [wbStatusCell cellWithTableView:tableView];
    
    //给cell传递statusFrame模型
    wbStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    cell.statusF = statusFrame;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取statusFrame模型
    wbStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    return statusFrame.cellHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
