//
//  ViewController.m
//  task2-4-6
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
- (IBAction)facebookiTap:(id)sender {
    SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSString* postContent = [NSString stringWithFormat:@"投稿内容"];
    [facebookPostVC setInitialText:postContent];
    [facebookPostVC addImage:[UIImage imageNamed:@"image1"]]; // 画像名（文字列）
    [self presentViewController:facebookPostVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
