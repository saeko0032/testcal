//
//  VideoViewController.m
//  RecordClass
//
//  Created by saekof on 2017-04-05.
//  Copyright © 2017 saeko0032. All rights reserved.
//

#import "VideoViewController.h"
#import <CoreVideo/CoreVideo.h>
#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>


@interface VideoViewController ()
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic) AVCaptureVideoDataOutput *videoDataOutput;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) UIImageView *previewImageView;

@end

@implementation VideoViewController

- (IBAction)takePhoto:(UIButton *)sender {
    [self takePhoto1:sender];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    // 撮影ボタンを配置したツールバーを生成
//    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
//    
//    UIBarButtonItem *takePhotoButton = [[UIBarButtonItem alloc] initWithTitle:@"撮影"
//                                                                        style:UIBarButtonItemStyleBordered
//                                                                       target:self
//                                                                       action:@selector(takePhoto:)];
//    toolbar.items = @[takePhotoButton];
//    [self.view addSubview:toolbar];
    
    // プレビュー用のビューを生成
    self.previewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                          20,
                                                                          self.view.bounds.size.width,
                                                                          self.view.bounds.size.height - 20)];
    [self.view addSubview:self.previewImageView];
    
    // 撮影開始
    [self setupAVCapture];
}

- (void)setupAVCapture
{
    NSError *error = nil;
    
    // 入力と出力からキャプチャーセッションを作成
    self.session = [[AVCaptureSession alloc] init];
    
    self.session.sessionPreset = AVCaptureSessionPresetMedium;
    
    // カメラからの入力を作成
    AVCaptureDevice *camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // カメラからの入力を作成し、セッションに追加
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:camera error:&error];
    [self.session addInput:self.videoInput];
    
    // 画像への出力を作成し、セッションに追加
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [self.session addOutput:self.videoDataOutput];
    
    // ビデオ出力のキャプチャの画像情報のキューを設定
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    [self.videoDataOutput setAlwaysDiscardsLateVideoFrames:TRUE];
    [self.videoDataOutput setSampleBufferDelegate:self queue:queue];
    
    // ビデオへの出力の画像は、BGRAで出力
    self.videoDataOutput.videoSettings = @{
                                           (id)kCVPixelBufferPixelFormatTypeKey : [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                           };
    
    // ビデオ入力のAVCaptureConnectionを取得
    AVCaptureConnection *videoConnection = [self.videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    
    // 1秒あたり4回画像をキャプチャ
    videoConnection.videoMinFrameDuration = CMTimeMake(1, 4);
    
    [self.session startRunning];
}

// AVCaptureVideoDataOutputSampleBufferDelegateプロトコルのメソッド。新しいキャプチャの情報が追加されたときに呼び出される。
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    // キャプチャしたフレームからCGImageを作成
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    
    // 画像を画面に表示
    dispatch_async(dispatch_get_main_queue(), ^{
        self.previewImageView.image = image;
    });
}

// サンプルバッファのデータからCGImageRefを生成する
- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // ピクセルバッファのベースアドレスをロックする
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get information of the image
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // RGBの色空間
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef newContext = CGBitmapContextCreate(baseAddress,
                                                    width,
                                                    height,
                                                    8,
                                                    bytesPerRow,
                                                    colorSpace,
                                                    kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    
    CGImageRef cgImage = CGBitmapContextCreateImage(newContext);
    
    CGContextRelease(newContext);
    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    UIImage *image = [UIImage imageWithCGImage:cgImage scale:1.0 orientation:UIImageOrientationRight];
    
    CGImageRelease(cgImage);
    
    return image;
}

- (void)takePhoto1:(id)sender
{
    AudioServicesPlaySystemSound(1108);
    
    // アルバムに画像を保存
    UIImageWriteToSavedPhotosAlbum(self.previewImageView.image, self, nil, nil);
}
@end
