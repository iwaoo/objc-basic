//
//  ViewController.m
//  task2-1-17
//
//  Created by 新井岩生 on 2017/12/28.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)submitButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil];
    UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerInSubStoryboard"];
    loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
