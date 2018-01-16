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
#import "TableViewProvider.h"
#import "Database.h"


@interface ViewController ()<UITableViewDelegate, AFNetworkingViewControllerDelegate>
    
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property AFNetworkingViewController *afNetWorkingView;
    @property TableViewProvider *provider;
    
@end

static CGFloat const tableCellHeight = 80;

@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    Database *database = [Database new];
    [database createDatabase];
    
    self.tableView.delegate =self;
    self.provider =[TableViewProvider new];
    self.tableView.dataSource = self.provider;
    
    self.afNetWorkingView = [AFNetworkingViewController new];
    self.afNetWorkingView.delegate = self;
    
    NSDictionary<NSString *, NSString *> *cities = @{@"city" : @"130010"};
    [self.afNetWorkingView getWeatherInfoData:cities];

}

#pragma mark - AFNetworkingViewControllerDelegate
/**
 AFNetworkingViewControllerDelegateを使って、天気データを受け取る
 */
-(void)finishedCreateDataList:(NSMutableArray *)dataList{
    self.provider.dataList = dataList;
    [self.tableView reloadData];
}
/** セルの高さ */
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableCellHeight;
}

@end

