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
#import "wbViewController_One.h"

#import "wbPhoto.h"
#import "wbUser.h"
#import "wbStatus.h"
#import "wbAccountTool.h"
#import "wbAccount.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface wbHomeViewController ()<wbCoverDelegate>

@property (nonatomic, weak) wbTitleButton *titleButton;
@property (nonatomic, strong) wbOneViewController *one;
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation wbHomeViewController

- (NSMutableArray *)statuses{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (wbOneViewController *)one{
    if (_one == nil) {
        _one = [[wbOneViewController alloc] init];
    }
    return _one;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNavigationBar];
    
    //下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    [self.tableView headerBeginRefreshing];
    
    //加载更多
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
}

#pragma mark - 加载更多
-(void)loadMoreStatus{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.statuses.count) {
        //若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        long long maxId = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        params[@"max_id"] = [NSString stringWithFormat:@"%lld",maxId];
    }
    params[@"access_token"] = [wbAccountTool account].access_token;
    
    //获取当前登录用户及其所关注（授权）用户的最新微博
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //结束加载更多
        [self.tableView footerEndRefreshing];
        
        //获取微博字典数组
        NSArray *dictArr = responseObject[@"statuses"];
        //把字典数组转换成模型数组
        NSArray *statuses = (NSMutableArray *)[wbStatus objectArrayWithKeyValuesArray:dictArr];
        
        //把数组中的元素添加进去
        [self.statuses addObjectsFromArray:statuses];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 下拉刷新
-(void)loadNewStatus{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.statuses.count) {
        //若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        params[@"since_id"] = [self.statuses[0] idstr];
    }
    params[@"access_token"] = [wbAccountTool account].access_token;
    
    //获取当前登录用户及其所关注（授权）用户的最新微博
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        //获取微博字典数组
        NSArray *dictArr = responseObject[@"statuses"];
        //把字典数组转换成模型数组
        NSArray *statuses = (NSMutableArray *)[wbStatus objectArrayWithKeyValuesArray:dictArr];
        
        //把最新的微博数插入到最前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.statuses insertObjects:statuses atIndexes:indexSet];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
    
    wbViewController_One *one = [[wbViewController_One alloc] init];
    one.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:one animated:YES];
    
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //获取status模型
    wbStatus *status = self.statuses[indexPath.row];
    
    //用户昵称
    cell.textLabel.text = status.user.name;
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    cell.detailTextLabel.text = status.text;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
