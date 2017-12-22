//
//  ViewController.m
//  task2-1-11
//
//  Created by 新井岩生 on 2017/12/22.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

    @property (weak, nonatomic) IBOutlet UITableView *table;
    @property NSArray *wrap;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // plistデータを読み込む
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    self.wrap = [NSArray arrayWithArray:dic[@"Wrap"]];
}
// セクション数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.wrap.count;
}
//タイトル
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.wrap[section][@"Title"];
}
// 行数
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *rows = self.wrap[section][@"Row"];
    return rows.count;
}



// セルにデータを書き込む
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    NSDictionary* wrapItem = self.wrap[indexPath.section];
    NSDictionary* rowItem =  wrapItem[@"Row"][indexPath.row];
    
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = rowItem[@"text"];
    cell.imageView.image = [UIImage imageNamed:rowItem[@"image"]];
    
    return cell;
}




@end

