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


@end
