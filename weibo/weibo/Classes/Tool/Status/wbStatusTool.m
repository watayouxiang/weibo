//
//  wbStatusTool.m
//  weibo
//
//  Created by 王涛 on 2016/11/1.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbStatusTool.h"
#import "wbHttpTool.h"
#import "wbStatus.h"
#import "wbStatusParam.h"
#import "wbStatusResult.h"
#import "wbAccountTool.h"
#import "wbAccount.h"

@implementation wbStatusTool

+(void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    wbStatusParam *param = [[wbStatusParam alloc] init];
    param.access_token = [wbAccountTool account].access_token;
    if (sinceId) {//有微博数据，才需要下拉刷新
        param.since_id = sinceId;
        
    }
    
    [wbHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        //字典转模型
        wbStatusResult *result = [wbStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{

    wbStatusParam *param = [[wbStatusParam alloc] init];
    param.access_token = [wbAccountTool account].access_token;
    if (maxId) {//有微博数据，才需要下拉刷新
        param.max_id = maxId;
        
    }
    
    [wbHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {

        //字典转模型
        wbStatusResult *result = [wbStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
