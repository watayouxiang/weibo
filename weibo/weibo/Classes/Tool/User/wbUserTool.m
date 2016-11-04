//
//  wbUserTool.m
//  weibo
//
//  Created by 王涛 on 2016/11/2.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbUserTool.h"
#import "wbUserParam.h"
#import "wbAccountTool.h"
#import "wbAccount.h"
#import "wbHttpTool.h"
#import "MJExtension.h"
#import "wbUserResult.h"
#import "wbUser.h"

@implementation wbUserTool

+ (void)unreadWithSuccess:(void (^)(wbUserResult *))success failure:(void (^)(NSError *))failure{
    
    wbUserParam *param = [wbUserParam param];
    param.uid = [wbAccountTool account].uid;
    
    [wbHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        //字典转换模型
        wbUserResult *result = [wbUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userInfoWithSuccess:(void(^)(wbUser *user))success failure:(void(^)(NSError *error))failure{
    
    //创建参数模型
    wbUserParam *param = [wbUserParam param];//access_token
    param.uid = [wbAccountTool account].uid;//uid
    
    [wbHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        //字典转模型
        wbUser *user = [wbUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
