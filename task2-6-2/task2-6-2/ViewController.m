//
//  ViewController.m
//  task2-6-2
//
//  Created by 新井岩生 on 2018/01/16.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 通知センターにUIApplicationDidBecomeActiveNotification通知がされた時に、setSteamParametersメソッドを呼び出す
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSteamParameters) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSteamParameters{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appdelegate.host != nil){
        self.captionLabel.text = appdelegate.caption;
        self.commentLabel.text = appdelegate.comment;
    };
}

@end
