//
//  TYLiveCell.h
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/25.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYLiveModel;
@interface TYLiveCell : UITableViewCell

@property (nonatomic, strong) TYLiveModel *liveModel;

+ (instancetype)cellForXib;

@end
