//
//  Weather.h
//  task2-4-1
//
//  Created by 新井岩生 on 2017/12/26.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
    @property (strong, nonatomic) NSString *text;
    @property (strong, nonatomic) NSDate *dateLabel;
    @property (strong, nonatomic) NSString *telop;
    @property (strong, nonatomic) NSString *imageUrl;

    - (instancetype)initWithDate:(NSDate *) date weather:(NSString *) weather icon:(NSString *) icon;

@end
