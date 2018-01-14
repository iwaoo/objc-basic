//
//  Weather.m
//  task2-4-1
//
//  Created by 新井岩生 on 2017/12/26.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "Weather.h"

@implementation Weather
-(instancetype)initWithDate:(NSDate *)date weather:(NSString *)weather icon:(NSString *)icon{
    if (self = [super init]) {
        self.dateLabel = date;
        self.telop = weather;
        self.imageUrl = icon;
    }
    return self;
}

@end
