//
//  TodoModel.h
//  task2-3-2
//
//  Created by 新井岩生 on 2017/12/25.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoModel : NSObject

@property NSInteger todo_id;
@property NSString *todo_title;
@property NSDate *limit_date;
@property BOOL delete_flg;
-(id)initWithID:(NSInteger) todo_id title:(NSString *) todo_title limitDate:(NSDate *) limit_date ;

@end
