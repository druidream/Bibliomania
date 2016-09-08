//
//  BMScanViewController.m
//  Bibliomania
//
//  Created by Gu Jun on 3/5/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import "BMScanViewController.h"
#import "AVFoundation/AVFoundation.h"
#import "DoubanISBNResolver.h"
#import "BookItem.h"
#import "BMDoubanJSONResult.h"

@interface BMScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>//用于处理采集信息的代理

{
    AVCaptureSession * session;//输入输出的中间桥梁
}
@property (nonatomic, copy) NSMutableArray *bookItems;

@end

@implementation BMScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bookItems = [[NSMutableArray alloc] init];
    
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc] init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        
        AudioServicesPlaySystemSound(1114);
        
        [session stopRunning];
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(resumeSession) userInfo:nil repeats:NO];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0];
        //输出扫描字符串
//        NSLog(@"%@",metadataObject.stringValue);
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [self p_resolveISBN:metadataObject.stringValue];
//        });
        DoubanISBNResolver *resolver = [[DoubanISBNResolver alloc] init];
        [resolver resolve:metadataObject.stringValue completion:^(id responseData) {
//            NSLog(@"... responseString : %@", responseString);
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                BMDoubanJSONResult *result = [[BMDoubanJSONResult alloc] initWithDictionary:responseData error:nil];
//                NSLog(@"... response dic : %@", result);
                self.bookItems
            } else if ([responseData isKindOfClass:[NSString class]]) {
                BMDoubanJSONResult *result = [[BMDoubanJSONResult alloc] initWithString:responseData error:nil];
                NSLog(@"... response str : %@", result);
            }
        }];
    }
}

- (IBAction)doneButtonDidClick:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)resumeSession {
    [session startRunning];
}

@end
