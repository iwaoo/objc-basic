//
//  TodoModel.m
//  task2-3-2
//
//  Created by 新井岩生 on 2017/12/25.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "TodoModel.h"

@implementation TodoModel

-(id)initWithID:(NSInteger)todo_id title:(NSString *)todo_title limitDate:(NSDate *)limit_date{
    if(self = [super init]){
        self.todo_id = todo_id;
        self.todo_title = todo_title;
        self.limit_date = limit_date;
        _delete_flg = NO;
    }
    return self;
}

@end
