//
//  TYTabBarViewController.m
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/25.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYTabBarViewController.h"
#import "TYHomeViewController.h"

@interface TYTabBarViewController ()

@end

@implementation TYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVcs];
}

#pragma mark - 添加子控制器

- (void)setupChildVcs {
    
    TYHomeViewController *homeVc = [[TYHomeViewController alloc] init];
    homeVc.title = @"首页";
    UINavigationController *home_navVc = [[UINavigationController alloc] initWithRootViewController:homeVc];
    [self addChildViewController:home_navVc];
    
}

@end
