//
//  TableViewProvider.m
//  task2-4-1
//
//  Created by 新井岩生 on 2018/01/15.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "TableViewProvider.h"

@implementation TableViewProvider

#pragma mark - tableView
/** セルの行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
/** セルに内容を書き込む */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].telop];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:self.dataList[indexPath.row].dateLabel]];
    
    NSString *imageURL = self.dataList[indexPath.row].imageUrl;
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];
    cell.imageView.image = image;
    cell.clipsToBounds = YES;//frameサイズ外を描画しない
    
    return cell;
}

@end
