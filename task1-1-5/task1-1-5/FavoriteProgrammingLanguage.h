//
//  FavoriteProgrammingLanguage.h
//  task1-1-5
//
//  Created by 新井岩生 on 2017/12/07.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  FavoriteProgrammingLanguageDelegate <NSObject>
@optional
-(void)catchDelegate: (NSString *)string;
@end

@interface FavoriteProgrammingLanguage : NSObject

@property(nonatomic,assign)id<FavoriteProgrammingLanguageDelegate> delegate;
-(NSString *)throwDelegate:(NSString *)message;

@end
