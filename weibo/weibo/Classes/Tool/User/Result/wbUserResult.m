//
//  wbUserResult.m
//  weibo
//
//  Created by 王涛 on 2016/11/2.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbUserResult.h"

@implementation wbUserResult

- (int)messageCount{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totoalCount{
    return self.messageCount + _status + _follower;
}

@end
