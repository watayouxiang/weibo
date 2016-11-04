//
//  wbAccount.m
//  weibo
//
//  Created by 王涛 on 2016/10/28.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbAccount.h"
#import "MJExtension.h"

#define wbAccountTokenKey @"token"
#define wbUidKey @"uid"
#define wbExpires_inKey @"exoires"
#define wbExpires_dateKey @"date"
#define wbNameKey @"name"

@implementation wbAccount

+(instancetype)accountWithDict:(NSDictionary *)dict{
    wbAccount *account = [[wbAccount alloc] init];
    
    /**
     KVC底层实现：遍历字典里的所有key(uid)
     一个一个获取key，会去模型里查找setKey: setUid:,直接调用这个方法，赋值 setUid:obj
     寻找有没有带下划线_key,_uid ,直接拿到属性赋值
     寻找有没有key的属性，如果有，直接赋值
     在模型里面找不到对应的Key,就会报错.
     */
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

-(void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
    
    //过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

//底层实现了当前类所有属性的归档和解档
//MJCodingImplementation

#pragma mark - 归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_access_token forKey:wbAccountTokenKey];
    [aCoder encodeObject:_expires_in forKey:wbExpires_inKey];
    [aCoder encodeObject:_uid forKey:wbUidKey];
    [aCoder encodeObject:_expires_date forKey:wbExpires_dateKey];
    [aCoder encodeObject:_name forKey:wbNameKey];
}

#pragma mark - 解档
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _access_token =  [aDecoder decodeObjectForKey:wbAccountTokenKey];
        _expires_in = [aDecoder decodeObjectForKey:wbExpires_inKey];
        _uid = [aDecoder decodeObjectForKey:wbUidKey];
        _expires_date = [aDecoder decodeObjectForKey:wbExpires_dateKey];
        _name = [aDecoder decodeObjectForKey:wbNameKey];
    }
    return self;
}


@end
