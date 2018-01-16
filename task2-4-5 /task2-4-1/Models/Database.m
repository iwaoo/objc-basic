//
//  Database.m
//  task2-4-1
//
//  Created by 新井岩生 on 2018/01/15.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "Database.h"
#import "FMDB.h"

@implementation Database
/** sqliteテーブルを作る */
- (void)createDatabase {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filedPath = [[paths firstObject] stringByAppendingPathComponent:@"weather1.db"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filedPath];
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS table_weather(id integer PRIMARY KEY, date DATETIME, weather TEXT,icon TEXT);";
    
    [fm open];
    [fm executeUpdate:sql];
    [fm close];
}

@end
