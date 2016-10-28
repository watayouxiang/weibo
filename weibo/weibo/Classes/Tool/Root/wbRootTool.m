//
//  wbRootTool.m
//  weibo
//
//  Created by 王涛 on 2016/10/28.
//  Copyright © 2016年 wata. All rights reserved.
//  专门处理根控制器的业务（有新特性页面先进入新特性页面，没有直接进入主界面）

#import "wbRootTool.h"
#import "wbTabBarController.h"
#import "wbNewFeatureController.h"

#define wbVersionKey @"version"

@implementation wbRootTool

+(void)chooseRootViewController:(UIWindow *)window{

    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:wbVersionKey];

    if ([currentVersion isEqualToString:lastVersion]) {
        wbTabBarController *tabBarVc = [[wbTabBarController alloc] init];
        window.rootViewController = tabBarVc;                
    }else{
        wbNewFeatureController *newFeatureVc = [[wbNewFeatureController alloc] init];
        window.rootViewController = newFeatureVc;
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:wbVersionKey];
    }
}

@end
