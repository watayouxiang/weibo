//
//  wbNavigationController.m
//  weibo
//
//  Created by 王涛 on 2016/10/20.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbNavigationController.h"

@interface wbNavigationController ()

@end

@implementation wbNavigationController

#pragma mark - 类初始化的时候调用一次
+ (void)initialize{
    //获取当前类下的tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObject:self]];
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
