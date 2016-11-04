//
//  NSDate+wb.h
//  weibo
//
//  Created by 王涛 on 2016/11/4.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (wb)

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

@end
