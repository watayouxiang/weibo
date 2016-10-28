//
//  wbAccountTool.h
//  weibo
//
//  Created by 王涛 on 2016/10/28.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <Foundation/Foundation.h>

@class wbAccount;

@interface wbAccountTool : NSObject

+(void)saveAccount:(wbAccount *)account;
+(wbAccount *)account;

@end
