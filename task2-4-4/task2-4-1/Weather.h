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
<<<<<<< HEAD
    -(instancetype)initWithDate:(NSDate *) date weather:(NSString *) weather icon:(NSString *) icon NS_DESIGNATED_INITIALIZER;
=======
    -(id)initWithDate:(NSDate *) date weather:(NSString *) weather icon:(NSString *) icon;
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872

@end
