//
//  ViewController.m
//  task2-3-2
//
//  Created by 新井岩生 on 2017/12/20.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "TodoModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray<TodoModel *> *dataList;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:@"firstRunDate2"]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filedPath = [[paths firstObject] stringByAppendingPathComponent:@"test.db"];
        FMDatabase *fm = [[FMDatabase alloc] initWithPath:filedPath];
        [fm open];
        [fm executeUpdate:@"CREATE TABLE IF NOT EXISTS tr_todo (todo_id INTEGER PRIMARY KEY AUTOINCREMENT, todo_title TEXT, todo_contents TEXT,created DATETIME,modified DATETIME,limit_date DATETIME,delete_flg BOOL);"];
    }
    // 初回起動日時を設定
    [ud setObject:[NSDate date] forKey:@"firstRunDate2"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self makeTodoModelData];
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataList[indexPath.row].todo_title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_dataList[indexPath.row].limit_date]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // データ消去処理
        [self makeDeleteFlgOn:_dataList[indexPath.row].todo_id];
        [self makeTodoModelData];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
        
    }
    
}

-(void)makeTodoModelData{
    _dataList = [[NSMutableArray alloc]init];
    
    NSString *sql = @"SELECT todo_id,todo_title,limit_date FROM tr_todo WHERE delete_flg = ? ORDER BY limit_date;";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filedPath = [[paths firstObject] stringByAppendingPathComponent:@"test.db"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filedPath];
    [fm open];
    FMResultSet *results = [fm executeQuery:sql,[NSNumber numberWithBool:NO]];
    while( [results next] ) {
        int todo_id = [results intForColumn:@"todo_id"];
        NSString *todo_title = [results stringForColumn:@"todo_title"];
        NSDate *limit_date = [results dateForColumn:@"limit_date"];
        [_dataList addObject:[[TodoModel alloc] initWithID:todo_id title:todo_title limitDate:limit_date]];
    }
    [fm close];
}

-(void)makeDeleteFlgOn:(NSInteger)todo_id{
    NSString *sql =  @"UPDATE tr_todo SET delete_flg = ? WHERE todo_id = ?;";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filedPath = [[paths firstObject] stringByAppendingPathComponent:@"test.db"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filedPath];
    [fm open];
    [fm executeUpdate:sql, [NSNumber numberWithBool:YES], [NSNumber numberWithInt:(int)todo_id
                                                            ]];
    [fm close];
    
}


@end
