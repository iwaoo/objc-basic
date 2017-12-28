//
//  ViewController.m
//  kadai2-1-2
//
//  Created by 新井岩生 on 2017/12/08.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // UIImageViewインスタンス
    UIImageView * imageView = [[UIImageView alloc] init];
    // UIImage インスタンスの作成
    UIImage *image = [UIImage imageNamed:@"image1"];
    // UIImageView 初期化
    imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 4.0;
    // UIImageViewのインスタンスをビューに追加
    [self.view addSubview:imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
