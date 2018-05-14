//
//  ViewController.m
//  task1_1_1
//
//  Created by 新井岩生 on 2017/12/05.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // BOLL型.
    BOOL answer = YES;
    NSLog(answer ? @"Yes" : @"No");
    
    // NSString型
    NSString *str = @"テスト";
    NSLog(@"%@", str);
    
    // NSInteger型
    NSInteger num = 100;
    NSLog(@"%zd", num);
    
    // short型→NSNumber型
    NSNumber *count = [NSNumber numberWithShort:32767];
    NSLog(@"%@", count);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
