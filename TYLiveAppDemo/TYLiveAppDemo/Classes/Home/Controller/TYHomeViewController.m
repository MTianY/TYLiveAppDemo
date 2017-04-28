//
//  TYHomeViewController.m
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/25.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYHomeViewController.h"
#import "TYLiveViewController.h"
#import "TYCaptureViewController.h"
#import "TYBeautyFilterViewController.h"

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

#pragma mark - 进入采集界面
- (IBAction)turnIntoCaptureInput:(UIButton *)sender {
    
//    TYCaptureViewController *captureVc = [[TYCaptureViewController alloc] init];
//    captureVc.title = @"采集界面";
//    [self presentViewController:captureVc animated:YES completion:nil];
    
    TYBeautyFilterViewController *beautyFilterVc = [[TYBeautyFilterViewController alloc] init];
    beautyFilterVc.title = @"采集界面";
    [self presentViewController:beautyFilterVc animated:YES completion:nil];
    
}

@end
