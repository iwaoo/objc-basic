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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filedPath = [[paths firstObject] stringByAppendingPathComponent:@"test.db"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filedPath];
    [fm open];
    [fm executeUpdate:@"CREATE TABLE IF NOT EXISTS tr_todo (todo_id INTEGER PRIMARY KEY AUTOINCREMENT, todo_title TEXT, todo_contents TEXT,created DATETIME,modified DATETIME,limit_date DATETIME,delete_flg BOOL);"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self makeTodoModelData];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].todo_title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_dataList[indexPath.row].limit_date]];
    
    return cell;
}

-(void)makeTodoModelData{
    self.dataList = [[NSMutableArray alloc]init];
    
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
        [self.dataList addObject:[[TodoModel alloc] initWithID:todo_id title:todo_title limitDate:limit_date]];
    }
    [fm close];
}


@end
