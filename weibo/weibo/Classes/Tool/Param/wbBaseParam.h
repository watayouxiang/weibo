//
//  wbBaseParam.h
//  weibo
//
//  Created by 王涛 on 2016/11/2.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface wbBaseParam : NSObject

/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

+(instancetype)param;

@end
