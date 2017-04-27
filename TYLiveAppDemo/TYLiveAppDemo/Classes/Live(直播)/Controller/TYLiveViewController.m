//
//  TYLiveViewController.m
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/25.
//  Copyright © 2017年 MTY. All rights reserved.
//  直播列表

#import "TYLiveViewController.h"
#import <AFNetworking.h>
#import "TYLiveCell.h"
#import <MJExtension/MJExtension.h>
#import "TYLiveModel.h"
#import "TYLiveRoomViewController.h"

#define YKURL @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"

@interface TYLiveViewController ()

@property (nonatomic, strong) NSArray *lives;

@end

@implementation TYLiveViewController

#pragma mark - lazy load

- (NSArray *)lives {
    if (nil == _lives) {
        _lives = [NSArray array];
    }
    return _lives;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 取消系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self loadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark - Load Data

- (void)loadData {
    
//    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    NSString *urlStr = YKURL;
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        self.lives = [TYLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"liveCell";
    TYLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [TYLiveCell cellForXib];
    }
    cell.liveModel = self.lives[indexPath.row];
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 450;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TYLiveRoomViewController *liveRoomVc = [[TYLiveRoomViewController alloc] init];
    liveRoomVc.liveModel = self.lives[indexPath.row];
    [self presentViewController:liveRoomVc animated:YES completion:nil];
}


@end
