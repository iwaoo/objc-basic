//
//  ViewController.m
//  Test
//
//  Created by 新井岩生 on 2017/12/14.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

    @property (nonatomic, retain) NSMutableArray *imageNameArray;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self arraySetUp];
}


- (void)arraySetUp {
    self.imageNameArray = [NSMutableArray arrayWithArray: @[@"image1",@"image2",@"image3",@"image4"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%zd 番目のセクション", section];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.imageNameArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // plistデータを読み込む
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    // データをテーブルセルに書き込む
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    if (indexPath.section == 0) {
        cell.textLabel.numberOfLines = 0;// 文字の時はセルの高さ可変
        cell.textLabel.text = [dic objectForKey:_imageNameArray[indexPath.row]];
    } else if (indexPath.section == 1){
        cell.imageView.image = [UIImage imageNamed:[dic objectForKey:_imageNameArray[indexPath.row]]];
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@""];
    
    return cell;
}



@end
