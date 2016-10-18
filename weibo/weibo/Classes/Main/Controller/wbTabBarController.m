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

@interface wbTabBarController ()

@end

@implementation wbTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildViewController];
    
    //自定义tabBar
    wbTabBar *tabBar = [[wbTabBar alloc] initWithFrame:self.tabBar.frame];
    //利用KVC修改readOnly属性
    [self setValue:tabBar forKey:@"tabBar"];
    
}

#pragma mark - 初始化子控制器
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
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.badgeValue = @"10";
    
    [self addChildViewController:vc];
    
}



@end
