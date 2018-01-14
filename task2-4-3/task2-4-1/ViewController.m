//
//  ViewController.m
//  task2-4-1
//
//  Created by 新井岩生 on 2017/12/26.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
    // weatherApiReCall型ブロック宣言
    typedef void (^weatherApiReCall)(NSMutableArray<Weather *> *weatherHandler);
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property NSUInteger h;

@end

static NSString *const weatherInfoUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1";

@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}
// blockでコールバック
- (void)getWeatherInfoData:(NSDictionary<NSString *, NSString *> *)cities recall:(weatherApiReCall)recall {
    NSMutableArray *weatherHandler = [NSMutableArray new];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [manager GET:weatherInfoUrl
      parameters:cities
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
             
             for (NSDictionary<NSString *, NSString *> *forecasts in responseObject[@"forecasts"]) {
                 Weather *weather = [Weather new];
                 weather.text = responseObject[@"description"][@"text"];
                 weather.dateLabel = [formatter dateFromString:forecasts[@"date"]];
                 weather.telop = forecasts[@"telop"];
                 weather.imageUrl = [forecasts valueForKeyPath:@"image.url"];
                 [weatherHandler addObject:weather];
             }
             recall(weatherHandler);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
             recall(nil);
         }
     ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSDictionary<NSString *, NSString *> *cities = @{@"city" : @"130010"};
    [self getWeatherInfoData:cities recall:^(NSMutableArray<Weather *> *weatherHandler) {
        if (indexPath.row != 3) {
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
                        cell.textLabel.text = [formatter stringFromDate:weatherHandler[indexPath.row].dateLabel];
                        cell.detailTextLabel.text = weatherHandler[indexPath.row].telop;
                        cell.imageView.image = image;
                        [cell layoutSubviews];
                    });

                } @catch (NSException *exception) {
                    NSLog(@"error");
                }
            });
        } else {
            @try {
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text = weatherHandler[2].text;
                cell.detailTextLabel.text = @"";
            } @catch (NSException *exception) {
                NSLog(@"error");
            }

        }

    }];
    cell.clipsToBounds = YES;//frameサイズ外を描画しない
    return cell;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        self.h = 700;
    } else {
        self.h = 100;
    }
    return self.h;
}

@end
