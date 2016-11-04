//
//  wbStatusCell.h
//  weibo
//
//  Created by 王涛 on 2016/11/4.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class wbStatusFrame;

@interface wbStatusCell : UITableViewCell

/**
 *  Frame模型
 */
@property (nonatomic, strong) wbStatusFrame *statusF;

/**
 *  构造方法
 */
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
