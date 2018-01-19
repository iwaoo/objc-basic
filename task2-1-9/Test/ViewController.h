//
//  ViewController.h
//  Test
//
//  Created by 新井岩生 on 2017/12/14.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIView *pickerViewContainer;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

- (IBAction)showBtn:(id)sender;
- (IBAction)hideBtn:(id)sender;


@end

