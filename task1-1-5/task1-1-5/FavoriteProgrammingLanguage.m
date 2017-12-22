//
//  FavoriteProgrammingLanguage.m
//  task1-1-5
//
//  Created by 新井岩生 on 2017/12/07.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "FavoriteProgrammingLanguage.h"

@interface FavoriteProgrammingLanguage ()

@property (strong, nonatomic) NSString *message1;
@property (strong, nonatomic) NSString *message2;

@end


@implementation FavoriteProgrammingLanguage

-(NSString *)throwDelegate{
    self.message1 = @"インターンに参加する";
    self.message2 = @" bj-cができる";
    if ([self.delegate respondsToSelector:@selector(catchDelegate:)]) {
        [self.delegate catchDelegate:self.message2];
    }
    return self.message1;
}

@end
