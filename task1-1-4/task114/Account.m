//
//  Account.m
//  task114
//
//  Created by 新井岩生 on 2017/12/07.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "Account.h"

@implementation Account

- (id) init {
    return nil;
}

// 引数ありのイニシャライザの実装
- (id)initWithName:(NSString *)nameValue initWithAge:(int)ageValue initWithSex:(NSString *)sexValue initWithGoodPoint:(NSString *)goodPointValue {
    self = [super init];
    if (self != nil) {
        self.name = nameValue;
        self.age = ageValue;
        self.sex = sexValue;
        self.good_point = goodPointValue;
    }
    return self;
}

@end
