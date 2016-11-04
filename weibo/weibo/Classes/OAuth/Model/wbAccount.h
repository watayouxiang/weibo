//
//  wbAccount.h
//  weibo
//
//  Created by 王涛 on 2016/10/28.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface wbAccount : NSObject<NSCoding>

/**
 *  用户授权的唯一票据，用于调用微博的开放接口
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  access_token的生命周期，单位是秒数
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *  access_token的生命周期（该参数即将废弃，开发者请使用expires_in）
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  授权用户的UID
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  过期时间 = 当前保存时间+有效期
 */
@property (nonatomic, strong) NSDate *expires_date;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end
