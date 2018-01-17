//
//  ViewController.m
//  task2-4-1
//
//  Created by 新井岩生 on 2017/12/26.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworkingViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "FMDB.h"
#import "Weather.h"



@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, AFNetworkingViewControllerDelegate>

    @property FMDatabase *fm;
    @property NSMutableArray<Weather *> *dataList;
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property AFNetworkingViewController *afNetWorkingView;
    
@end

static CGFloat const tableCellHeight = 80;



@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filedPath = [[paths firstObject] stringByAppendingPathComponent:@"weather1.db"];
    self.fm = [[FMDatabase alloc] initWithPath:filedPath];
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS table_weather(id integer PRIMARY KEY, date DATETIME UNIQUE, weather TEXT,icon TEXT);";
    
    [self.fm open];
    [self.fm executeUpdate:sql];
    [self.fm close];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.afNetWorkingView = [AFNetworkingViewController new];
    self.afNetWorkingView.delegate = self;
    
    NSDictionary<NSString *, NSString *> *cities = @{@"city" : @"130010"};
    [self.afNetWorkingView getWeatherInfoData:cities];

}

/**
 AFNetworkingViewControllerDelegateを使って、天気データを受け取る
 */
-(void)finishedCreateDataList:(NSMutableArray *)dataList{
    self.dataList = dataList;
    [self.tableView reloadData];
}
#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

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

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableCellHeight;
}

@end

