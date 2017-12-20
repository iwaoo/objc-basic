//
//  ViewController.m
//  Test
//
//  Created by 新井岩生 on 2017/12/19.
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
    self.navigationItem.title = @"First View";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapBringNextPageBtn:(id)sender {
    [self performSegueWithIdentifier:@"SegueToNextPage" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SegueToNextPage"]) {
        SecondViewController *secondVC=(SecondViewController *)segue.destinationViewController;
        secondVC.dataString=self.inputTextField.text;
    }
}
@end
