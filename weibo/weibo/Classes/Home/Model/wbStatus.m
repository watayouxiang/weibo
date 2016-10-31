//
//  wbStatus.m
//  weibo
//
//  Created by 王涛 on 2016/10/31.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbStatus.h"
#import "wbPhoto.h"

@implementation wbStatus

//实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[wbPhoto class]};
}

@end
