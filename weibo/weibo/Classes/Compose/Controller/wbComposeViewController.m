//
//  wbComposeViewController.m
//  weibo
//
//  Created by 王涛 on 2016/11/14.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbComposeViewController.h"

@interface wbComposeViewController ()

@end

@implementation wbComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavgationBar];
}

- (void)setupNavgationBar{
    self.title = @"发微博";
    
    //left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    //right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)compose{
    
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
