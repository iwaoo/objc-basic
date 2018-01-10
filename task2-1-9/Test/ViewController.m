//
//  ViewController.m
//  Test
//
//  Created by 新井岩生 on 2017/12/14.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerViewContainer.frame = CGRectMake(0, 687, 375, 283);

    // ラベルをタッチポイントに
    self.label.userInteractionEnabled = YES;
    self.label.tag = 100;
    // 背景をタッチポイントに
    self.backgroundView.userInteractionEnabled = YES;
    self.backgroundView.tag = 101;
}

// タップされたとき
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ( touch.view.tag == self.label.tag ) {
        [self showBtn:self.label];
    } else if (touch.view.tag == self.backgroundView.tag) {
        [self hideBtn:self.backgroundView];
    }
}

- (IBAction)showBtn:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _pickerViewContainer.frame = CGRectMake(0, 387, 375, 283);
    [UIView commitAnimations];

}

- (IBAction)hideBtn:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _pickerViewContainer.frame = CGRectMake(0, 687, 375, 283);
    [UIView commitAnimations];
    if ((id)sender != self.backgroundView) {// Doneボタンがクリックされた時ラベルに値を書き込む
        // 日付の表示形式を設定
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy/MM/dd HH:mm";
        
        self.label.text = [NSString stringWithFormat:@"%@", [df stringFromDate:_datePicker.date]];
    }
}
@end
