//
//  wbOAuthViewController.m
//  weibo
//
//  Created by 王涛 on 2016/10/27.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "wbAccount.h"
#import "wbAccountTool.h"
#import "wbRootTool.h"

@interface wbOAuthViewController ()<UIWebViewDelegate>

@end

@implementation wbOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"2703609498";
    NSString *redirect_uri = @"http://www.baidu.com";
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    webView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webView代理
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //获取code（RequestToken）
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        wbLog(@"%@",urlStr);
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        wbLog(@"%@",code);
        
        //获取accessToken
        [self accessTokenWithCode:code];
        
        return NO;
    }

    return YES;
}

#pragma mark - 根据code获取accountToken
-(void)accessTokenWithCode:(NSString *)code{
    [wbAccountTool accountWithCode:code success:^{
        // 进入主页或者新特性,选择窗口的根控制器
        [wbRootTool chooseRootViewController:wbKeyWindow];
    } failure:^(NSError *error) {
        
    }];
}

@end
