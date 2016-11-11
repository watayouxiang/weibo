//
//  wbStatus.m
//  weibo
//
//  Created by 王涛 on 2016/10/31.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbStatus.h"
#import "wbPhoto.h"
#import "NSDate+wb.h"

@implementation wbStatus

//实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[wbPhoto class]};
}

- (NSString *)created_at{
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *created_at = [fmt dateFromString:_created_at];
    
    if ([created_at isThisYear]) {//今年
        if ([created_at isToday]) {//今天
            // 计算跟当前时间差距
            NSDateComponents *cmp = [created_at deltaWithNow];
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
            }else{
                return @"刚刚";
            }
        }else if ([created_at isYesterday]){//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return  [fmt stringFromDate:created_at];
        }else{//前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return  [fmt stringFromDate:created_at];
        }
    }else{//不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    
    return _created_at;
}

- (void)setSource:(NSString *)source{
    /**
     <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
     来自:微博 weibo.com
     */
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自: %@",source];
    
    _source = source;
}

-(void)setRetweeted_status:(wbStatus *)retweeted_status{
    _retweeted_status = retweeted_status;
    
    _retweetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}

@end
