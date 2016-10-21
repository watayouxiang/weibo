//
//  wbTabBarController.m
//  weibo
//
//  Created by 王涛 on 2016/10/18.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbTabBarController.h"
#import "UIImage+wbImage.h"
#import "wbTabBar.h"

#import "wbHomeViewController.h"
#import "wbProfileViewController.h"
#import "wbDiscoverViewController.h"
#import "wbMessageViewController.h"

#import "wbNavigationController.h"

@interface wbTabBarController ()<wbTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation wbTabBarController

-(NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildViewController];
    
    [self setupTabBar];
    
}

#pragma mark - 设置自定义tabBar
-(void)setupTabBar{
    //自定义tabBar
    wbTabBar *tabBar = [[wbTabBar alloc] initWithFrame:self.tabBar.frame];
    
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.delegate = self;
    tabBar.items = self.items;
    
    [self.view addSubview:tabBar];
    [self.tabBar removeFromSuperview];
}

#pragma mark - 点击tabBar上的tabBarItem时调用
- (void)tabBar:(wbTabBar *)tabBar didClickButton:(NSInteger)index{
    self.selectedIndex = index;
}

#pragma mark - 设置所有子控制器
-(void)setupAllChildViewController{
    
    UIViewController *home = [[UIViewController alloc] init];
    [self setupOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    home.view.backgroundColor = [UIColor greenColor];
    
    
    UIViewController *message = [[UIViewController alloc] init];
    [self setupOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    message.view.backgroundColor = [UIColor blueColor];
    
    
    UIViewController *discover = [[UIViewController alloc] init];
    [self setupOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    discover.view.backgroundColor = [UIColor purpleColor];
    
    
    UIViewController *profile = [[UIViewController alloc] init];
    [self setupOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    profile.view.backgroundColor = [UIColor lightGrayColor];
    
    
}

#pragma mark - 添加一个子控制器
-(void)setupOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    
    //vc.title = title;//代表了：vc.navigationItem.title = title; vc.tabBarItem.title = title;
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.badgeValue = @"10";
    
    [self.items addObject:vc.tabBarItem];
    
    wbNavigationController *nav = [[wbNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
}



@end
