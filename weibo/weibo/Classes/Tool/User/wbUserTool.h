//
//  wbUserTool.h
//  weibo
//
//  Created by 王涛 on 2016/11/2.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <Foundation/Foundation.h>
@class wbUserResult,wbUser;

@interface wbUserTool : NSObject

/**
 *  请求用户的未读数
 *  success 请求成功的回调
 *  failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(wbUserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(wbUser *user))success failure:(void(^)(NSError *error))failure;

@end
