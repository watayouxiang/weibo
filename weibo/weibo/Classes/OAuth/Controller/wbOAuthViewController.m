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

#define wbAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define wbClient_id     @"2703609498"
#define wbRedirect_uri  @"http://www.baidu.com"
#define wbClient_secret @"270a34e4a0c591bb1ce94f9d20d42d83"

@interface wbOAuthViewController ()<UIWebViewDelegate>

@end

@implementation wbOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",wbAuthorizeBaseUrl,wbClient_id,wbRedirect_uri];
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

-(void)accessTokenWithCode:(NSString *)code{
    //发送Post请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = wbClient_id;
    params[@"client_secret"] = wbClient_secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = wbRedirect_uri;
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        wbLog(@"%@", responseObject);
        
        //字典转模型
        wbAccount *account = [wbAccount accountWithDict:responseObject];
        
        //保存账号信息
        [wbAccountTool saveAccount:account];
        
        //进入主页或者新特征页面
        [wbRootTool chooseRootViewController:wbKeyWindow];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        wbLog(@"%@", error);
        
    }];
    
}

@end
