//
//  ViewController.m
//  task2-1-18
//
//  Created by 新井岩生 on 2017/12/29.
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

- (IBAction)toSecondViewAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle: nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SecondView"];
    //[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    [self.navigationController pushViewController:vc animated:YES];
    //[self presentViewController:vc animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
