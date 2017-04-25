//
//  TYHomeViewController.m
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/25.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYHomeViewController.h"
#import "TYLiveViewController.h"

@interface TYHomeViewController ()

@end

@implementation TYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 进入直播界面
- (IBAction)turnIntoLive:(UIButton *)sender {
    
    TYLiveViewController *liveVc = [[TYLiveViewController alloc] init];
    liveVc.title = @"主播列表";
    [self presentViewController:liveVc animated:YES completion:nil];
    
}


@end
