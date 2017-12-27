//
//  EntryViewController.m
//  task2-3-2
//
//  Created by 新井岩生 on 2017/12/21.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "EntryViewController.h"
#import "FMDB.h"

@interface EntryViewController ()

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitAction:(id)sender {
    if (self.titleTextField.text != nil && [self.titleTextField.text length] > 0)
    {
        
        // 今の日時
        NSDate* date = [NSDate date];
        
        // 3日後
        NSDate* limitDate = [NSDate dateWithTimeIntervalSinceNow:3*24*60*60];
        NSString *sql = @"INSERT INTO tr_todo (todo_title, todo_contents, created, modified, limit_date, delete_flg) VALUES (?, ?, ?, ?, ?, ?);";
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filedPath = [[paths firstObject] stringByAppendingPathComponent:@"test.db"];
        FMDatabase *fm = [[FMDatabase alloc] initWithPath:filedPath];
        [fm open];
        [fm executeUpdate:sql, self.titleTextField.text, self.contentTextField.text, date,date,limitDate ,[NSNumber numberWithBool:NO]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        [fm close];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.messageLabel.text = @"タイトルは入力必須項目！";
    }
}
@end
