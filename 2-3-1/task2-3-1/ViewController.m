//
//  ViewController.m
//  task2-3-1
//
//  Created by 新井岩生 on 2017/12/20.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:@"firstRunDate"]) {
        // 日時が設定済みなら初回起動でない
        [ud setInteger:100 forKey:@"KEY_I"];  // int型の100をKEY_Iというキーで保存
        [ud setDouble:1.23 forKey:@"KEY_D"];  // double型の1.23をKEY_Dというキーで保存
        [ud setObject:@"hoge" forKey:@"KEY_S"];  // をKEY_Sというキーの初期値はhoge
        long i = [ud integerForKey:@"KEY_I"];  // KEY_Iの内容をint型として取得
        double d = [ud doubleForKey:@"KEY_D"];  // KEY_Dの内容をdouble型として取得
        NSString *s = [ud stringForKey:@"KEY_S"];  // KEY_Sの内容をNSString型として取得
        NSLog(@"%ld", i);
        NSLog(@"%f", d);
        NSLog(@"%@", s);
    }
    // 初回起動日時を設定
    [ud setObject:[NSDate date] forKey:@"firstRunDate"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
