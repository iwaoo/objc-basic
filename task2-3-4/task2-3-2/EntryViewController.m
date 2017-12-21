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
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd 'at' HH:mm";
        NSString *formattedDateString = [dateFormatter stringFromDate:date];
        // 3日後
        NSDate* limitDate = [NSDate dateWithTimeIntervalSinceNow:3*24*60*60];
        dateFormatter.dateFormat = @"yyyy-MM-dd 'at' HH:mm";
        NSString *limitDateString = [dateFormatter stringFromDate:limitDate];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filedPath = [[paths firstObject] stringByAppendingPathComponent:@"testdb"];
        FMDatabase *fm = [[FMDatabase alloc] initWithPath:filedPath];
        [fm open];
        [fm executeUpdate:@"INSERT INTO tr_todo (todo_title, todo_contents, created, modified, limit_date) VALUES (?, ?,?,?,?)",[NSString stringWithFormat:@"%@", self.titleTextField.text] , [NSString stringWithFormat:@"%@", self.contentTextField.text], [NSString stringWithFormat:@"%@",formattedDateString], [NSString stringWithFormat:@"%@",formattedDateString], [NSString stringWithFormat:@"%@",limitDateString],nil];
        
        FMResultSet *results = [fm executeQuery:@"SELECT * FROM tr_todo"];
        while([results next]) {
            NSLog(@"%@", [results stringForColumn:@"limit_date"]);
        }
        [fm close];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        self.messageLabel.text = @"タイトルは入力必須項目！";
    }
}
@end
