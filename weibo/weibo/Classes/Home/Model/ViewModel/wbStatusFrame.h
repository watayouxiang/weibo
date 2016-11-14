//
//  wbStatusFrame.h
//  weibo
//
//  Created by 王涛 on 2016/11/4.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <Foundation/Foundation.h>

@class wbStatus;

@interface wbStatusFrame : NSObject

//----------------------微博数据----------------------

// 微博数据
@property (nonatomic, strong) wbStatus *status;

//----------------------原创微博frame----------------------

// 原创微博frame
@property (nonatomic, assign) CGRect originalViewFrame;

// 头像Frame
@property (nonatomic, assign) CGRect originalIconFrame;

// 昵称Frame
@property (nonatomic, assign) CGRect originalNameFrame;

// vipFrame
@property (nonatomic, assign) CGRect originalVipFrame;

// 时间Frame
@property (nonatomic, assign) CGRect originalTimeFrame;

// 来源Frame
@property (nonatomic, assign) CGRect originalSourceFrame;

// 正文Frame
@property (nonatomic, assign) CGRect originalTextFrame;

// 配图Frame
@property (nonatomic, assign) CGRect originalPhotosFrame;

//----------------------转发微博frame----------------------

// 转发微博frame
@property (nonatomic, assign) CGRect retweetViewFrame;

// 昵称Frame
@property (nonatomic, assign) CGRect retweetNameFrame;

// 正文Frame
@property (nonatomic, assign) CGRect retweetTextFrame;

// 配图Frame
@property (nonatomic, assign) CGRect retweetPhotosFrame;

//----------------------工具条frame----------------------

// 工具条frame
@property (nonatomic, assign) CGRect toolBarFrame;

//----------------------cell的高度----------------------

// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
