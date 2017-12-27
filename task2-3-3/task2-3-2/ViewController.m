//
//  ViewController.m
//  task2-3-2
//
//  Created by 新井岩生 on 2017/12/20.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filedPath = [[paths firstObject] stringByAppendingPathComponent:@"testdb"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filedPath];
    [fm open];
    [fm executeUpdate:@"create table if not exists tr_todo (todo_id, todo_title, todo_contents, created, modified, limit_date, delete_flg);"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
