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
    Account *account1 = [[Account alloc] initWithName:@"山田" initWithAge:(int)25 initWithSex:@"女性" initWithGoodPoint:@"objective-c"];
    Account *account2 = [[Account alloc] initWithName:@"岩田" initWithAge:(int)26 initWithSex:@"男性" initWithGoodPoint:@"objective-c"];
    Account *account3 = [[Account alloc] initWithName:@"藤田" initWithAge:(int)22 initWithSex:@"女性" initWithGoodPoint:@"javascript"];
    NSString *man = @"男性";
    if (account1.sex == man) {
        NSLog(@"%@%@%@%@%d%@", account1.name, @"君は", account1.good_point, @"が得意な", account1.age, @"歳です。");
    } else {
        NSLog(@"%@%@%@%@%d%@", account1.name, @"さんは", account1.good_point, @"が得意な", account1.age, @"歳です。");
    }
    if (account2.sex == man) {
        NSLog(@"%@%@%@%@%d%@", account2.name, @"君は", account2.good_point, @"が得意な", account2.age, @"歳です。");
    } else {
        NSLog(@"%@%@%@%@%d%@", account2.name, @"さんは", account2.good_point, @"が得意な", account2.age, @"歳です。");
    }
    if (account3.sex == man) {
        NSLog(@"%@%@%@%@%d%@", account3.name, @"君は", account3.good_point, @"が得意な", account3.age, @"歳です。");
    } else {
        NSLog(@"%@%@%@%@%d%@", account3.name, @"さんは", account3.good_point, @"が得意な", account3.age, @"歳です。");
    }
}

@end
