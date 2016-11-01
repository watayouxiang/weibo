//
//  wbStatusTool.h
//  weibo
//
//  Created by 王涛 on 2016/11/1.
//  Copyright © 2016年 wata. All rights reserved.
//
//  微博数据层封装

#import <Foundation/Foundation.h>

@interface wbStatusTool : NSObject

/**
 *  请求更新的微博数据
 *  sinceId    返回比这个更大的微博数据
 *  success    请求成功的时候回调
 *  failure    请求失败的时候回调
 */
+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

/**
 *  请求更多的微博数据
 *  maxId      返回小于等于这个id的微博数据
 *  success    请求成功的时候回调
 *  failure    请求失败的时候回调
 */
+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

@end
