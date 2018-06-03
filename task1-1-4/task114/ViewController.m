//
//  ViewController.m
//  task114
//
//  Created by 新井岩生 on 2017/12/07.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "Account.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Account のインスタンスを定義
    Account *account = [[Account alloc] init];
    
    // メンバー一覧
    NSArray *num1 = @[@"山田君は", @"２５",@"男性", @"objective-c"];
    NSArray *num2 = @[@"岩田君は", @"２6",@"男性", @"objective-c"];
    NSArray *num3 = @[@"藤田さんは", @"２2",@"女性", @"javascript"];
    
    NSArray *num = @[num1,num2,num3];
    for(id s in num)
    {
        NSString *s_name = [NSString stringWithFormat:@"%@", s[0]];
        account.name = s_name;
        
        NSString *s_age = [NSString stringWithFormat:@"%@", s[1]];
        int i_age = [s_age intValue];
        account.age = i_age;
        
        NSString *s_sex = [NSString stringWithFormat:@"%@", s[2]];
        account.sex = s_sex;
        
        NSString *s_good_point = [NSString stringWithFormat:@"%@", s[3]];
        account.good_point = s_good_point;
        
        NSString *str = [account introduceMethod];
        NSLog(@"%@", str);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
