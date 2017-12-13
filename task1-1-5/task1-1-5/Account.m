//
//  Account.m
//  task114
//
//  Created by 新井岩生 on 2017/12/07.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "Account.h"
#import "FavoriteProgrammingLanguage.h"

@interface Account () <FavoriteProgrammingLanguageDelegate>

@end

@implementation Account

// インターンに参加メドッド
- (void) callData{
    FavoriteProgrammingLanguage *favoriteProgrammingLanguage = [FavoriteProgrammingLanguage new];
    favoriteProgrammingLanguage.delegate = self;
    [favoriteProgrammingLanguage throwDelegate];
}

// bj-cができる通知
- (void)catchDelegate:(NSString *)string
{
    NSLog(@"%@", string);
}

@end






