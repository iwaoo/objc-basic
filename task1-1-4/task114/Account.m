//
//  Account.m
//  task114
//
//  Created by 新井岩生 on 2017/12/07.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "Account.h"

@implementation Account

- (NSString *) introduceMethod{
    NSString *result=[NSString stringWithFormat:@"%@%@%@%d%@", self.name, self.good_point, @"が得意な", self.age, @"歳です。"];
    return result;
}

@end
