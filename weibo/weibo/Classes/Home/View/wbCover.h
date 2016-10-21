//
//  wbCover.h
//  weibo
//
//  Created by 王涛 on 2016/10/21.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class wbCover;

@protocol wbCoverDelegate <NSObject>

@optional

- (void)coverDidClickCover:(wbCover *)cover;

@end

@interface wbCover : UIView

@property (nonatomic, assign) BOOL dimBackground;
@property (nonatomic, weak) id<wbCoverDelegate> delegate;

+ (instancetype)show;

@end
