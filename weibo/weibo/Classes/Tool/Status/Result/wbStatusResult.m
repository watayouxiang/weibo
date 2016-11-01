//
//  wbStatusResult.m
//  weibo
//
//  Created by 王涛 on 2016/11/1.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbStatusResult.h"
#import "wbStatus.h"

@implementation wbStatusResult

+(NSDictionary *)objectClassInArray{
    return @{@"statuses":[wbStatus class]};
}

@end
