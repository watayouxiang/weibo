//
//  wbBaseParam.m
//  weibo
//
//  Created by 王涛 on 2016/11/2.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbBaseParam.h"
#import "wbAccountTool.h"
#import "wbAccount.h"

@implementation wbBaseParam

+(instancetype)param{
    wbBaseParam *param = [[self alloc] init];
    param.access_token = [wbAccountTool account].access_token;
    return param;
}

@end
