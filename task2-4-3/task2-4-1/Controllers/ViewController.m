//
//  ViewController.m
//  task2-4-1
//
//  Created by 新井岩生 on 2017/12/26.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"
#import "WeatherTableViewCell.h"
#import "AFNetworkingViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static CGFloat const tableCellHeight = 300;
static int const sectionRows = 3;

@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

/** セルの行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return sectionRows;
}
/** 内容をセルに書き込む */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellIdentifier = @"Cell";
    WeatherTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary<NSString *, NSString *> *cities = @{@"city" : @"130010"};
    AFNetworkingViewController *AFNetworkingView = [AFNetworkingViewController new];
    [AFNetworkingView getWeatherInfoData:cities recall:^(NSMutableArray<Weather *> *weatherHandler) {
            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            cell.imageView.image = nil;
            dispatch_async(q_global, ^{
                @try {
                    NSString *imageURL = weatherHandler[indexPath.row].imageUrl;
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];
                    dispatch_async(q_main, ^{
                        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                        [formatter setDateFormat:@"yyyy-MM-dd"];
                        cell.telop.text = weatherHandler[indexPath.row].telop;
                        cell.dateLabel.text = [formatter stringFromDate:weatherHandler[indexPath.row].dateLabel];
                        cell.detailLabel.text = weatherHandler[indexPath.row].text;
                        
                        cell.imageView.image = image;
                        [cell layoutSubviews];
                    });

                } @catch (NSException *exception) {
                    NSLog(@"error");
                }
            });
    }];
    cell.clipsToBounds = YES;//frameサイズ外を描画しない
    return cell;
}
/** セルの高さ　*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableCellHeight;
}

@end
