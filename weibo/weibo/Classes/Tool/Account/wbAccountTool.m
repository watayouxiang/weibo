//
//  wbAccountTool.m
//  weibo
//
//  Created by 王涛 on 2016/10/28.
//  Copyright © 2016年 wata. All rights reserved.
//  专门处理账号的业务（账号存储和读取）

#import "wbAccountTool.h"
#import "wbAccount.h"

#define wbAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

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

@end
