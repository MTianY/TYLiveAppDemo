//
//  Readme.m
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/25.
//  Copyright © 2017年 MTY. All rights reserved.
//

## 播放部分

1.集成 ijkplayer

2.将打包的静态库拖入工程内

3.[核心]直播部分

[1]"IJKFFMoviePlayerController"这个类专门用来做直播
[2]只要获取到直播需要的"流地址".根据 IJKFFMoviePlayerController 这个类就可以播放
[3]"prepareToPlay" 准备播放
[4]将 IJKFFMoviePlayerController 类对象的 view 插入到 当前控制器的view上面显示出来即可
[5]在结束播放的时候,记得要关闭直播
"pause" 及 "stop". 否则就会报 "内存溢出" 的错误

## 采集部分

1.AVFoundation
[1]主要处理音视频的数据采集

2.BUG

[1]
"This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSMicrophoneUsageDescription key with a string value explaining to the user how the app uses this data."

解决: 如要求在infoPlist设置即可.

3.切换摄像头功能
[1]首先获取当前设备摄像头的位置
[2]获取需要改变的方向(前置 or 后置)
[3]根据需要改变的方向来获取摄像头设备
[4]获取新的摄像头输入设备
[5]移除之前的摄像头输入设备
[6]添加新的摄像头输入设备
[7]记录当期那摄像头输入设备

4.聚焦模式
[1]点击屏幕聚焦
[2]首先要获取点击位置
[3]将当前的点击位置转成摄像头点上的位置
[4]设置聚焦点光标位置
>光标有个缩放动画
[5]设置聚焦
