//
//  ViewController.m
//  task2-1-6
//
//  Created by 新井岩生 on 2017/12/11.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *errorStrLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // デリゲート
    self.webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com/iphone/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
}

// ロード時インジケータ
- (void)webViewDidStartLoad:(UIWebView*)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// ロード完了
- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// ネットオフライン対策
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

    if (error.code == NSURLErrorNotConnectedToInternet) {
        self.errorStrLabel.text = @"通信エラー！";

    }
}


@end
