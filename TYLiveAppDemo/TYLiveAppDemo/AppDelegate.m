//
//  AppDelegate.m
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/25.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "AppDelegate.h"
#import "TYTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    TYTabBarViewController *tabBarVc = [[TYTabBarViewController alloc] init];
    self.window.rootViewController = tabBarVc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
