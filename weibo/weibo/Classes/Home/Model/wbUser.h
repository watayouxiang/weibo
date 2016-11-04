//
//  wbUser.h
//  weibo
//
//  Created by 王涛 on 2016/10/31.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface wbUser : NSObject

/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/**
 *  会员类型 > 2代表是会员
 */
@property (nonatomic, assign) int mbtype;

/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;

/**
 *  是否是会员
 */
@property (nonatomic, assign,getter=isVip) BOOL vip;

@end
