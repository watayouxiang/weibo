//
//  wbViewController_One.m
//  weibo
//
//  Created by 王涛 on 2016/10/25.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbViewController_One.h"
#import "wbViewController_Two.h"

@interface wbViewController_One ()

@end

@implementation wbViewController_One

- (IBAction)jump2Two:(id)sender {
    wbViewController_Two *two = [[wbViewController_Two alloc] init];
    [self.navigationController pushViewController:two animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end