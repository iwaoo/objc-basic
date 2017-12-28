//
//  ViewController.m
//  Test
//
//  Created by 新井岩生 on 2017/12/14.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
    @property (weak, nonatomic) IBOutlet UITableView *table;
    @property(nonatomic) NSArray *item1;
    @property(nonatomic) NSArray *item2;
    @property(nonatomic) NSArray *item3;
    @property(nonatomic) NSArray *item4;

    @property(nonatomic) NSInteger numberOfRows;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // plistデータを読み込む
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *item1 = [dic objectForKey:@"item1"];
    NSArray *item2 = [dic objectForKey:@"item2"];
    NSArray *item3 = [dic objectForKey:@"item3"];
    NSArray *item4 = [dic objectForKey:@"item4"];
    self.item1 = item1;
    self.item2 = item2;
    self.item3 = item3;
    self.item4 = item4;
    
    self.numberOfRows = [dic count];
    self.navigationItem.title = @"ナビゲーションバー";
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRows;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    // データをテーブルセルに書き込む
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    cell.textLabel.numberOfLines = 0;// 文字の時はセルの高さ可変

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = self.item1[1];
            cell.imageView.image = [UIImage imageNamed:self.item1[0]];
            break;
        case 1:
            cell.textLabel.text = self.item2[1];
            cell.imageView.image = [UIImage imageNamed:self.item2[0]];
            break;
        case 2:
            cell.textLabel.text = self.item3[1];
            cell.imageView.image = [UIImage imageNamed:self.item3[0]];
            break;
        case 3:
            cell.textLabel.text = self.item4[1];
            cell.imageView.image = [UIImage imageNamed:self.item4[0]];
            break;
        default:
            break;
    }


    cell.detailTextLabel.text = [NSString stringWithFormat:@""];
    
    return cell;
}



@end
