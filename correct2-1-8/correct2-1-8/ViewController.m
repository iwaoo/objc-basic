//
//  ViewController.m
//  correct2-1-8
//
//  Created by 新井岩生 on 2017/12/20.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSArray *myDataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myDataArray = @[@"Red",@"Yellow",@"Orange",@"Green",@"Blue",@"Black"];
    self.pickerView.delegate =self;
    
    // ラベルをタッチポイントに
    self.label.userInteractionEnabled = YES;
    self.label.tag = 100;
    // 背景をタッチポイントに
    self.backgroundView.userInteractionEnabled = YES;
    self.backgroundView.tag = 101;
    
    self.pickerViewContainer.hidden =YES;
    //    self.datePicker.hidden = YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.myDataArray count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.label.text = [self.myDataArray objectAtIndex:row];
    
    switch (row) {
        case 0:
            self.label.backgroundColor= [UIColor redColor];
            break;
        case 1:
            self.label.backgroundColor= [UIColor yellowColor];
            break;
        case 2:
            self.label.backgroundColor=[UIColor orangeColor];
            break;
        case 3:
            self.label.backgroundColor=[UIColor greenColor];
            break;
        case 4:
            self.label.backgroundColor=[UIColor blueColor];
            self.label.textColor=[UIColor whiteColor];
            break;
        case 5:
            self.label.backgroundColor=[UIColor blackColor];
            self.label.textColor=[UIColor whiteColor];
            break;
        default:
            break;
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.myDataArray objectAtIndex:row];
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
    self.pickerViewContainer.hidden =NO;
    //   self.datePicker.hidden = NO;
    
}

- (IBAction)hideBtn:(id)sender {
    self.pickerViewContainer.hidden =YES;
    //    self.datePicker.hidden = YES;
}
@end
