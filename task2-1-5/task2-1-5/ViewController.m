//
//  ViewController.m
//  task2-1-5
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


- (IBAction)actionSheetBtnEnter:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"選択" message:@"どれにしますか？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // ボタンを配置
    [alertController addAction:[UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectedActionWith:1];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Twitter" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectedActionWith:2];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Line" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectedActionWith:3];
    }]];
    
    alertController.popoverPresentationController.sourceView = self.view;
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)selectedActionWith:(int)index{
    if (index == 1) {
        NSLog(@"Facebookを選択した");
    } else if(index == 2){
        NSLog(@"Twitterを選択した");
    } else if(index == 3){
        NSLog(@"Lineを選択した");
    }
}
@end
