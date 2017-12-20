//
//  ViewController.m
//  Test
//
//  Created by 新井岩生 on 2017/12/17.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.deviceImages.image = [UIImage imageNamed:self.strImage];
    self.pageIndexLabel.text = [NSString stringWithFormat:@"%d%@",(int)self.pageIndex + 1, @"/6"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
