//
//  ViewController.m
//  task2-1-4
//
//  Created by 新井岩生 on 2017/12/09.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)alertBtnEnter:(id)sender {
    
    //アラートコントローラーのインスタンスを生成
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"本当に終わりにしてもいいですか？" preferredStyle:UIAlertControllerStyleAlert];
    
    // 左から順にボタンが配置
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self otherButtonPushed];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self cancelButtonPushed];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)cancelButtonPushed {
    NSLog(@"いいえ！");
}
- (void)otherButtonPushed {
    NSLog(@"はい！");
}
@end
