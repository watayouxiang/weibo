//
//  AppDelegate.m
//  weibo
//
//  Created by 王涛 on 2016/10/18.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "AppDelegate.h"
#import "wbOAuthViewController.h"
#import "wbAccountTool.h"
#import "wbRootTool.h"
#import "UIImageView+WebCache.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册消息通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    //设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    //后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //单独播放一个后台程序
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    
    [session setActive:YES error:nil];
    
    //---------------------------
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //判断是否有授权
    if ([wbAccountTool account]) {//有授权：进入新特性页面或者主页面
        [wbRootTool chooseRootViewController:self.window];
    }else{//没有授权：进行授权操作
        wbOAuthViewController *oauthVc = [[wbOAuthViewController alloc] init];
        self.window.rootViewController = oauthVc;
    }

    [self.window makeKeyAndVisible];
    
    return YES;
}

//接收到内存警告的时候调用
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

//失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    
    /**
     如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
     但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
     微博：在程序即将失去焦点的时候播放静音音乐
     */
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    //无限播放
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
    
}

//程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 当后台任务结束的时候调用
        [application endBackgroundTask:ID];
    }];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
