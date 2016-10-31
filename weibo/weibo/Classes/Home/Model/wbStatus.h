//
//  wbStatus.h
//  weibo
//
//  Created by 王涛 on 2016/10/31.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "wbUser.h"

@interface wbStatus : NSObject<MJKeyValue>

@property (nonatomic, strong) wbStatus *retweeted_status;
@property (nonatomic, strong) wbUser *user;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, assign) int reposts_count;
@property (nonatomic, assign) int comments_count;
@property (nonatomic, assign) int attitudes_count;
@property (nonatomic, strong) NSArray *pic_urls;

@end
