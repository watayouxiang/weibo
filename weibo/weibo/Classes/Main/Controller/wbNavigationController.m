//
//  wbNavigationController.m
//  weibo
//
//  Created by 王涛 on 2016/10/20.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbNavigationController.h"
#import "UIBarButtonItem+wbItem.h"

@interface wbNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation wbNavigationController

#pragma mark - 类初始化的时候调用一次
+ (void)initialize{
    //获取当前类下的tabBarItem
   UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObject:self]];
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:att forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;

}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (viewController == self.viewControllers[0]) {
        //如果是根控制器，就要把滑动返回代理还原
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        //如果不是根控制器，就把滑动返回代理清空，滑动返回功能就会恢复
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //设置非根控制器的导航栏
    if (self.viewControllers.count != 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)backToRoot{
    [self popToRootViewControllerAnimated:YES];
}

-(void)backToPre{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
