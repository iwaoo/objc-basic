//
//  ViewController.m
//  task2-1-3
//
//  Created by 新井岩生 on 2017/12/09.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSArray *imageList;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageList = @[@"Image1", @"Image2", @"Image3", @"Image4", @"Image5"];
}

- (void)buttonWasTapped:(UIButton *)button
{
    // ランダムに画像を呼ぶ出す
    
    NSInteger rNum = arc4random() % [self.imageList count];
    
    self.backgroundImageView.image = [UIImage imageNamed: self.imageList[rNum]];
    
}


@end

