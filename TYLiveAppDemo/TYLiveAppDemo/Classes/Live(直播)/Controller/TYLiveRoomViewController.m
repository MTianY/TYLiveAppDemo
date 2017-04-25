//
//  TYLiveRoomViewController.m
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/25.
//  Copyright © 2017年 MTY. All rights reserved.
//  直播间

#import "TYLiveRoomViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "TYLiveModel.h"
#import <UIImageView+WebCache.h>

@interface TYLiveRoomViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *liveImageView;
@property (nonatomic, strong) IJKFFMoviePlayerController *ijkFFMoviePlayerVc;

@end

@implementation TYLiveRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

#pragma mark - LoadData

- (void)loadData {
    NSLog(@"怎么播放不了啊....😞😞😞😞");
    NSString *placeholderStr = self.liveModel.creator.portrait;
    [self.liveImageView sd_setImageWithURL:[NSURL URLWithString:placeholderStr] placeholderImage:nil];
    
    // 拉流地址
    NSString *urlStr = self.liveModel.stream_addr;
    
    // 创建 IJKFFMoviePlayerController 专门用来直播,传入流地址
    IJKFFMoviePlayerController *ijkFFMoviePlayVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:urlStr] withOptions:nil];
    self.ijkFFMoviePlayerVc = ijkFFMoviePlayVc;
    // 准备播放
    [ijkFFMoviePlayVc prepareToPlay];
    ijkFFMoviePlayVc.view.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:ijkFFMoviePlayVc.view atIndex:1];
}

- (IBAction)dismissedBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
