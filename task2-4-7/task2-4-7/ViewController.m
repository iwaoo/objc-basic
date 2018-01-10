//
//  ViewController.m
//  task2-4-7
//
//  Created by 新井岩生 on 2018/01/04.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)postAction:(id)sender {
    SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    NSString* postContent = [NSString stringWithFormat:@"投稿内容"];
    [twitterPostVC setInitialText:postContent];
    [twitterPostVC addImage:[UIImage imageNamed:@"image1"]]; // 画像名（文字列）
    [self presentViewController:twitterPostVC animated:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
