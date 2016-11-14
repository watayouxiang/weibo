//
//  wbTabBar.h
//  weibo
//
//  Created by 王涛 on 2016/10/18.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class wbTabBar;

@protocol wbTabBarDelegate <NSObject>

@optional
-(void)tabBar:(wbTabBar *)tabBar didClickButton:(NSInteger)index;

@optional
-(void)tabBarDidClickPlusButton:(wbTabBar *)tabBar;

@end

@interface wbTabBar : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<wbTabBarDelegate> delegate;

@end
