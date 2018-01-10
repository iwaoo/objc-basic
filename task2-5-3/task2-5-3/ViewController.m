//
//  ViewController.m
//  task2-5-3
//
//  Created by 新井岩生 on 2018/01/10.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCapturePhotoCaptureDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *previewView;

@property (nonatomic) AVCaptureSession  *captureSesssion;
@property AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) AVCapturePhotoOutput *imageOutput;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.hidden = YES;
    self.captureSesssion = [[AVCaptureSession alloc] init];
    self.captureSesssion.sessionPreset = AVCaptureSessionPreset1920x1080;
    self.imageOutput = [[AVCapturePhotoOutput alloc] init];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = [[NSError alloc] init];
    
    @try{
        AVCaptureDeviceInput* input = [[AVCaptureDeviceInput alloc] initWithDevice:device
                                                                             error:&error];
        if ([self.captureSesssion canAddInput:input]) {
            [self.captureSesssion addInput:input];
            if ([self.captureSesssion canAddOutput:self.imageOutput]) {
                [self.captureSesssion addOutput:self.imageOutput];
                [self.captureSesssion startRunning];
                AVCaptureVideoPreviewLayer* captureVideoLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSesssion];
                captureVideoLayer.frame = self.previewView.bounds;
                captureVideoLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                [self.previewView.layer addSublayer:captureVideoLayer];
            }
        }
    }
    @catch (NSException *ex){
        NSLog(@"%@",error);
    }
}
- (IBAction)takePhotoAction:(UIButton *)sender {
    AVCapturePhotoSettings* settings = [[AVCapturePhotoSettings alloc] init];
    settings.flashMode = AVCaptureFlashModeAuto;
    [self.imageOutput capturePhotoWithSettings:settings
                                           delegate:self];
    self.imageView.hidden =NO;
    self.previewView.hidden =YES;
}


- (IBAction)resetAction:(id)sender {
    self.imageView.hidden =YES;
    self.previewView.hidden =NO;
}

-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput
didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer
previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer
    resolvedSettings:(nonnull AVCaptureResolvedPhotoSettings *)resolvedSettings
     bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings
               error:(nullable NSError *)error
{
    NSData* photoData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer
                                                                    previewPhotoSampleBuffer:previewPhotoSampleBuffer];
    
    UIImage* resultImage = [[UIImage alloc] initWithData:photoData];
    self.imageView.image = resultImage;
    UIImageWriteToSavedPhotosAlbum(resultImage, nil, nil, nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
