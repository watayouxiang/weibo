//
//  wbUser.m
//  weibo
//
//  Created by 王涛 on 2016/10/31.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbUser.h"

@implementation wbUser

- (void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
