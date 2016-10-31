//
//  wbUser.h
//  weibo
//
//  Created by 王涛 on 2016/10/31.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface wbUser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSURL *profile_image_url;

@end
