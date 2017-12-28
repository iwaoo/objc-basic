//
//  Account.h
//  task114
//
//  Created by 新井岩生 on 2017/12/07.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property NSString *name;
@property int age;
@property NSString *sex;
@property NSString *good_point;

- (NSString *) introduceMethod;

@end
