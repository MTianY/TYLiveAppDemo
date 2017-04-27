//
//  TYCaptureViewController.m
//  TYLiveAppDemo
//
//  Created by 马天野 on 2017/4/27.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYCaptureViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface TYCaptureViewController () <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>
@property (nonatomic, strong) AVCaptureSession *avCaptureSession;
@property (nonatomic, strong) AVCaptureConnection *avCaptureConnection;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVCaptureDeviceInput *currentVideoDeviceInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;
@property (nonatomic, strong) AVCaptureDevice *currentDevice;
@property (nonatomic, strong) UIImageView *focusImageView;

@end

@implementation TYCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCaptureForAV];
}

#pragma mark - 音视频的采集
- (void)setupCaptureForAV {
    
    // 1.创建session,并预设图像质量及分辨率为 1280 * 720
    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
    captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
    self.avCaptureSession = captureSession;
    
    // 2.获取相机
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.currentDevice = videoDevice;
    // 2.获取声音设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    // 3.视频设备输入
    AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    self.currentVideoDeviceInput = videoDeviceInput;
    
    // 4.音频设备输入
    AVCaptureDeviceInput *audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    
    // 5.添加到会话
    if ([captureSession canAddInput:videoDeviceInput]) {
        [captureSession addInput:videoDeviceInput];
    }
    if ([captureSession canAddInput:audioDeviceInput]) {
        [captureSession addInput:audioDeviceInput];
    }
    
    // 6.获取视频数据输出设备
    AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    self.videoOutput = videoDataOutput;
    
    // 保证实时抛出,YES表示可抛弃丢失的帧
    [videoDataOutput setAlwaysDiscardsLateVideoFrames:YES];
    dispatch_queue_t videoQueue = dispatch_queue_create("video queue", NULL);
    // 使用代理来处理视频帧
    [videoDataOutput setSampleBufferDelegate:self queue:videoQueue];
    [captureSession addOutput:videoDataOutput];
    
    // 7.获取音频数据输出设备
    AVCaptureAudioDataOutput *audioDataOutput = [[AVCaptureAudioDataOutput alloc] init];
    dispatch_queue_t audioQueue = dispatch_queue_create("audio queue", NULL);
    // 使用代理处理音频帧
    [audioDataOutput setSampleBufferDelegate:self queue:audioQueue];
    [captureSession addOutput:audioDataOutput];
    
    // 8.设置输出方向
    // tips: 此步骤必须在 output 添加到 session 之后设置
    AVCaptureConnection *avCaptureConnection = [videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    self.avCaptureConnection = avCaptureConnection;
    // 视频以垂直方向输出
    avCaptureConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    // 9.创建视频预览图层
    AVCaptureVideoPreviewLayer *videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    self.videoPreviewLayer = videoPreviewLayer;
    videoPreviewLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer insertSublayer:videoPreviewLayer atIndex:0];
    
    // 10.开始采集
    [captureSession startRunning];
    
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
// 获取到采集信息
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    if (self.avCaptureConnection == connection) {
        NSLog(@"采集到了视频数据");
    }else {
        NSLog(@"采集到了音频数据");
    }
}

#pragma mark - 结束采集
- (IBAction)stopCaptureMethod:(UIButton *)sender {
    [self.avCaptureSession stopRunning];
    [self.videoPreviewLayer removeFromSuperlayer];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 切换摄像头
- (IBAction)SWAPMethod:(UIButton *)sender {
    
    [self.avCaptureSession beginConfiguration];
    
    // 1.获取当前设备摄像头位置
    AVCaptureDevicePosition currentPosition = self.currentVideoDeviceInput.device.position;
    // 2.获取需要改变的方向
    AVCaptureDevicePosition needChangePosition = currentPosition == AVCaptureDevicePositionFront ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
    // 3.根据需要改变的方向来获取摄像头设备
    AVCaptureDevice *needChangeDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:needChangePosition];
    // 4.获取新的摄像头输入设备
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:needChangeDevice error:nil];
    // 5.移除之前的摄像头输入设备
    [self.avCaptureSession removeInput:self.currentVideoDeviceInput];
    // 6.添加新的摄像头输入设备
    [self.avCaptureSession addInput:deviceInput];
    // 7.记录当前摄像头输入设备
    self.currentVideoDeviceInput = deviceInput;

    [self.avCaptureSession commitConfiguration];
    
}

#pragma mark - 点击屏幕获取焦点(聚焦)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 1.获得点击位置
    UITouch *curTouch = [touches anyObject];
    CGPoint curPoint = [curTouch locationInView:self.view];
    
    // 2.将当前点击的位置转成摄像头点上的位置
    CGPoint cameraPoint = [self.videoPreviewLayer captureDevicePointOfInterestForPoint:curPoint];
    
    // 3.设置聚焦点光标位置
    [self setupFocusWithPoint:curPoint];
    
    // 4.设置聚焦
    [self setupFocusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
    
}

// 设置聚焦光标位置
- (void)setupFocusWithPoint:(CGPoint)point {
    
    UIImageView *focusImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"focus_01"]];
    self.focusImageView = focusImageView;
    [self.view addSubview:focusImageView];
    focusImageView.center = point;
    focusImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    focusImageView.alpha = 1.0;
    [UIView animateWithDuration:1.0 animations:^{
        focusImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        focusImageView.alpha = 0.0;
    }];
    
}

// 设置聚焦
- (void)setupFocusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point {
    
    AVCaptureDevice *captureDevice = self.currentVideoDeviceInput.device;
    // 锁定配置
    [captureDevice lockForConfiguration:nil];
    
    // 设置聚焦
    if ([captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
    }
    if ([captureDevice isFocusPointOfInterestSupported]) {
        [captureDevice setFocusPointOfInterest:point];
    }
    
    // 设置曝光
    if ([captureDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
        [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
    }
    if ([captureDevice isExposurePointOfInterestSupported]) {
        [captureDevice setExposurePointOfInterest:point];
    }
    // 解锁配置
    [captureDevice unlockForConfiguration];
    
}

@end
