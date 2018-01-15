//
//  ViewController.m
//  task1-1-2
//
//  Created by 新井岩生 on 2017/12/06.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSArray型
    NSArray *fruits = @[@"りんご", @"なし",@"みかん"];
    for(id s in fruits)
    {
        NSLog(@"%@",(NSString*)s);
    }
    // NSDictionary型
    NSDictionary *pc = @{@"mac":@"マック", @"windows":@"ウインドウズ"};
    for (id key in [pc keyEnumerator]) {
        NSLog(@"%@", [pc valueForKey:key]);
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
