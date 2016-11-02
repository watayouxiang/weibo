//
//  wbUserParam.h
//  weibo
//
//  Created by 王涛 on 2016/11/2.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbBaseParam.h"

@interface wbUserParam : wbBaseParam

/**
 *  当前登录用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

@end
