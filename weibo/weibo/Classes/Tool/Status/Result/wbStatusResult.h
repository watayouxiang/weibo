//
//  wbStatusResult.h
//  weibo
//
//  Created by 王涛 on 2016/11/1.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface wbStatusResult : NSObject<MJKeyValue>

/**
 *  用户的微博数组（wbStatus）
 */
@property (nonatomic, strong) NSArray *statuses;

/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int *total_number;

@end
