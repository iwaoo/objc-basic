//
//  ViewController.m
//  Test
//
//  Created by 新井岩生 on 2017/12/12.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "OverlayView.h"


@interface ViewController ()<
UIPickerViewDelegate,
UIPickerViewDataSource
>
@property(nonatomic, strong) UIView *areaView;
@property(nonatomic, strong) UIPickerView *areaPickerView;
@property(nonatomic, strong) OverlayView *overlayView;

@property(nonatomic, strong) NSArray *areaList;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.areaList = @[
                      @[@"1", @"中華"],
                      @[@"2", @"フランス"],
                      @[@"3", @"イタリア"],
                      @[@"4", @"メキシコ"],
                      @[@"5", @"日本"],
                      @[@"6", @"韓国"],
                      @[@"7", @"トルコ"],
                      ];
    
    // ラベルをタッチポイントに
    self.cuisineLable.userInteractionEnabled = YES;
    self.cuisineLable.tag = 100;
    // 背景と作る
    self.overlayView = [[OverlayView alloc] initWithFrame:CGRectZero];
    self.overlayView.target = self;
    self.overlayView.action = @selector(hideAreaView);
    self.overlayView.backgroundColor = [UIColor whiteColor];
    self.overlayView.alpha = 0.4;
    [self.view addSubview:self.overlayView];
    
    [self buildAreaPickerView];
}

// ラベルはタッチされたとき
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ( touch.view.tag == self.cuisineLable.tag ) {
        [self showAreaView:self.cuisineLable];
    }
}

- (IBAction)showAreaView:(id)sender
{
    [self.view bringSubviewToFront:_overlayView];
    [self.view bringSubviewToFront:_areaView];
    self.overlayView.frame = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:.20 animations:^{
        self.areaView.transform = CGAffineTransformMakeTranslation(0, -(AREA_PICKER_ACCESSORY_HEIGHT + AREA_PICKER_HEIGHT));
    }];
}

- (void)hideAreaView
{
    [UIView animateWithDuration:.20 animations:^{
        self.areaView.transform = CGAffineTransformIdentity;
    }];
    self.overlayView.frame = CGRectZero;
}

static const float AREA_PICKER_ACCESSORY_HEIGHT = 44;
static const float AREA_PICKER_HEIGHT = 216;

- (void)buildAreaPickerView
{
    float height = self.view.bounds.size.height;
    float width = self.view.bounds.size.width;
    
    float areaViewHeight = AREA_PICKER_ACCESSORY_HEIGHT + AREA_PICKER_HEIGHT;
    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             height,
                                                             width,
                                                             areaViewHeight)];
    [self.view addSubview:self.areaView];
    
    UIView *areaPickerAccessoryView =
    [[UIView alloc] initWithFrame:CGRectMake(0,
                                             0,
                                             width,
                                             AREA_PICKER_ACCESSORY_HEIGHT)];
    areaPickerAccessoryView.backgroundColor = [UIColor redColor];
    
    const float DONE_BUTTON_WEDTH = 80;
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneBtn.frame = CGRectMake(width - DONE_BUTTON_WEDTH,
                               4,
                               DONE_BUTTON_WEDTH,
                               36);
    doneBtn.backgroundColor = [UIColor whiteColor];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn addTarget:self
                action:@selector(performAreaDoneButtonAction)
      forControlEvents:UIControlEventTouchUpInside];
    [areaPickerAccessoryView addSubview:doneBtn];
    [self.areaView addSubview:areaPickerAccessoryView];
    
    self.areaPickerView =
    [[UIPickerView alloc] initWithFrame:CGRectMake(0,
                                                   AREA_PICKER_ACCESSORY_HEIGHT,
                                                   width,
                                                   AREA_PICKER_HEIGHT)];
    self.areaPickerView.backgroundColor = [UIColor whiteColor];
    self.areaPickerView.delegate = self;
    self.areaPickerView.dataSource = self;
    [self.areaPickerView selectRow:2 inComponent:0 animated:NO];
    [self.areaView addSubview:self.areaPickerView];
}

- (void)performAreaDoneButtonAction
{
    NSInteger row = [self.areaPickerView selectedRowInComponent:0];
    NSLog(@"areaCode:%@, areaName:%@", self.areaList[row][0], self.areaList[row][1]);
    self.cuisineLable.text = self.areaList[row][1];
    [self hideAreaView];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.areaList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.areaList[row][1];
}

@end
