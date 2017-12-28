//
//  ViewController.m
//  task2-1-3
//
//  Created by 新井岩生 on 2017/12/09.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UIImageView *imageView_;
UIButton *button_;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ボダンクリック前の画像表示
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"Image1"] drawInRect:self.view.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    // ボダンを作る
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(50, 50, 150, 50);
    button.layer.borderColor = [[UIColor blackColor]CGColor];
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = 5.0;
    button.clipsToBounds = YES;
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"クリック" forState:UIControlStateNormal];
    // ボダンクリック
    [button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button_ = button;
}


- (void)buttonWasTapped:(UIButton *)button
{
    // ランダムに画像を呼ぶ出す
    NSArray *omikujiList = @[@"Image1", @"Image2", @"Image3", @"Image4", @"Image5"];
    NSInteger rNum = arc4random() % [omikujiList count];
    
    // 画面サイズに合わせて
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:omikujiList[rNum]] drawInRect:self.view.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
}


@end

