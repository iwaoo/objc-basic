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
#import "FMDB.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
// weatherApiReCall型ブロック宣言
typedef void (^weatherApiReCall)(NSMutableArray<Weather *> *weatherHandler);
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property NSUInteger h;
    @property FMDatabase *fm;
    @property NSMutableArray<Weather *> *dataList;

@end

static NSString *const weatherInfoUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1";

@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];


    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filedPath = [[paths firstObject] stringByAppendingPathComponent:@"weather.db"];
    self.fm = [[FMDatabase alloc] initWithPath:filedPath];
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS table_weather(id integer PRIMARY KEY, date DATETIME, weather TEXT,icon TEXT);";
    
    [self.fm open];
    [self.fm executeUpdate:sql];
    [self.fm close];
    
    NSDictionary<NSString *, NSString *> *cities = @{@"city" : @"130010"};
    [self getWeatherInfoData:cities recall:^(NSMutableArray<Weather *> *weatherHandler) {
//        NSLog(@"%@", weatherHandler[0].telop);
    }];
    NSString *d = @"SELECT date,weather,icon FROM table_weather;";
    [self.fm open];
    FMResultSet *results = [self.fm executeQuery:d,[NSNumber numberWithBool:NO]];
    self.dataList = [[NSMutableArray alloc]init];
    while( [results next] ) {
        NSDate *date = [results dateForColumn:@"date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *weather = [results stringForColumn:@"weather"];
        NSString *icon = [results stringForColumn:@"icon"];
        [self.dataList addObject:[[Weather alloc] initWithDate:date weather:weather icon:icon]];
    }
    [self.fm close];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
// blockでコールバック
- (void)getWeatherInfoData:(NSDictionary<NSString *, NSString *> *)cities recall:(weatherApiReCall)recall {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    [manager GET:weatherInfoUrl
      parameters:cities
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
             
             for (NSDictionary<NSString *, NSString *> *forecasts in responseObject[@"forecasts"]) {

                 NSString *sql = @"INSERT OR REPLACE INTO table_weather (date, weather, icon ) VALUES(?,?,?)";
                 [self.fm open];
                 [self.fm executeUpdate:sql,[formatter dateFromString:forecasts[@"date"]],forecasts[@"telop"],[forecasts valueForKeyPath:@"image.url"]];
                 [self.fm close];
             }
             recall(self.dataList);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
         }
     ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];


    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row].telop];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_dataList[indexPath.row].dateLabel]];
    
    NSString *imageURL = self.dataList[indexPath.row].imageUrl;
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];
    cell.imageView.image = image;

    cell.clipsToBounds = YES;//frameサイズ外を描画しない
    
    NSDate* limit_date = [NSDate dateWithTimeIntervalSinceNow:3*24*60*60];
    NSString *delete_sql = @"DELETE FROM table_weather WHERE date < ?";
    [self.fm open];
    [self.fm executeUpdate:delete_sql, limit_date];
    [self.fm close];
     
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
