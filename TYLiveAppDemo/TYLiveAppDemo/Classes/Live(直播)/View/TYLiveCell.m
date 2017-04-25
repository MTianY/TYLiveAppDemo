//
//  TYLiveCell.m
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/25.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYLiveCell.h"
#import <UIImageView+WebCache.h>
#import "TYLiveModel.h"

@interface TYLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *anchorIconImageView;          // 主播头像
@property (weak, nonatomic) IBOutlet UILabel *anchorNameLabel;                  // 主播昵称
@property (weak, nonatomic) IBOutlet UILabel *anchorAddressLabel;               // 主播地址
@property (weak, nonatomic) IBOutlet UILabel *audienceCountLabel;               // 观众数量
@property (weak, nonatomic) IBOutlet UIImageView *anchorLivePhotoImageView;     // 主播直播图像
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;                // 主播直播图像高度约束
@property (weak, nonatomic) IBOutlet UILabel *identifyLabel;                    // 主播直播图像上的直播标识Label

@end

@implementation TYLiveCell

+ (instancetype)cellForXib {
    return [[[NSBundle mainBundle] loadNibNamed:@"TYLiveCell" owner:nil options:nil] lastObject];
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 头像圆角
    self.anchorIconImageView.layer.cornerRadius = 20;
    self.anchorIconImageView.clipsToBounds = YES;
    // 直播标识圆角
    self.identifyLabel.layer.cornerRadius = 5;
    self.identifyLabel.clipsToBounds = YES;
}

- (void)setLiveModel:(TYLiveModel *)liveModel {
    _liveModel = liveModel;
    
    // 头像
    [self.anchorIconImageView sd_setImageWithURL:[NSURL URLWithString:liveModel.creator.portrait] placeholderImage:nil];
    // 昵称
    self.anchorNameLabel.text = liveModel.creator.nick;
    // 地址
    self.anchorAddressLabel.text = liveModel.city;
    // 观众数量
    self.audienceCountLabel.text = [NSString stringWithFormat:@"%zd 在看",liveModel.online_users];
    // 主播直播图像
    [self.anchorLivePhotoImageView sd_setImageWithURL:[NSURL URLWithString:liveModel.creator.portrait] placeholderImage:nil];
    
}



@end
