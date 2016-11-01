//
//  wbHttpTool.h
//  weibo
//
//  Created by 王涛 on 2016/11/1.
//  Copyright © 2016年 wata. All rights reserved.
//  网络层封装

#import <Foundation/Foundation.h>

@interface wbHttpTool : NSObject

/**
 *  发送get请求
 *  URLString  请求的基本的url
 *  parameters 请求的参数字典
 *  success    请求成功的回调
 *  failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  发送post请求
 *  URLString  请求的基本的url
 *  parameters 请求的参数字典
 *  success    请求成功的回调
 *  failure    请求失败的回调
 */
+ (void)Post:(NSString *)URLString parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

@end
