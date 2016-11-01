//
//  wbAccountTool.m
//  weibo
//
//  Created by 王涛 on 2016/10/28.
//  Copyright © 2016年 wata. All rights reserved.
//  专门处理账号的业务（账号存储和读取）

#import "wbAccountTool.h"
#import "wbAccount.h"
#import "AFNetworking.h"
#import "wbHttpTool.h"
#import "wbAccountParam.h"
#import "MJExtension.h"

#define wbAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

#define wbAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define wbClient_id     @"2703609498"
#define wbRedirect_uri  @"http://www.baidu.com"
#define wbClient_secret @"270a34e4a0c591bb1ce94f9d20d42d83"

@implementation wbAccountTool

//类方法一般用静态变量代替成员属性
static wbAccount *_account;

+(void)saveAccount:(wbAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:wbAccountFileName];
}

+(wbAccount *)account{
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:wbAccountFileName];
        
        // 判断账号是否过期，如果过期直接返回nil
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
        
    }
    return _account;
}

+(void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure{
    wbAccountParam *param = [[wbAccountParam alloc] init];
    param.client_id = wbClient_id;
    param.client_secret = wbClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = wbRedirect_uri;
    
    //param.keyValues: 模型转字典
    [wbHttpTool Post:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        
        //字典转模型
        wbAccount *account = [wbAccount accountWithDict:responseObject];
        //保存账号信息
        [wbAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
