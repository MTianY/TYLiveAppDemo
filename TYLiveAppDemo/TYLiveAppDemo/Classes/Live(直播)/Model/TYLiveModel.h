//
//  TYLiveModel.h
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/25.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYCreatorModel.h"

@interface TYLiveModel : NSObject

/** 主播所在城市 */
@property (nonatomic, copy) NSString *city;
//@property (nonatomic, strong) NSString *share_addr;     // 主播直播地址
/** 在线观众 */
@property (nonatomic, assign) NSInteger online_users;
/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 主播 */
@property (nonatomic, strong) TYCreatorModel *creator;

@end
