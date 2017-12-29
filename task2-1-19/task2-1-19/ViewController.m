//
//  ViewController.m
//  task2-1-19
//
//  Created by 新井岩生 on 2017/12/29.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"First View";
}

- (IBAction)didTapBringNextPageBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle: nil];
    SecondViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SecondView"];
    
    vc.str = self.inputTextField.text;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
