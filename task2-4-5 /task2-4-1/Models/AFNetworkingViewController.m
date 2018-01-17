//
//  AFNetworkingViewController.m
//  task2-4-1
//
//  Created by 新井岩生 on 2018/01/12.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "AFNetworkingViewController.h"
#import "Weather.h"
#import <AFNetworking/AFNetworking.h>
#import "FMDB.h"

@interface AFNetworkingViewController ()
@property FMDatabase *fm;
@end

static NSString *const weatherInfoUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1";


@implementation AFNetworkingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataFromDatabase {
    NSString *d = @"SELECT date,weather,icon FROM table_weather;";
    [self.fm open];
    FMResultSet *results = [self.fm executeQuery:d,@NO];
    
    NSMutableArray *dataList = [@[] mutableCopy];
    
    while( [results next] ) {
        NSDate *date = [results dateForColumn:@"date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *weather = [results stringForColumn:@"weather"];
        NSString *icon = [results stringForColumn:@"icon"];
        
        [dataList addObject:[[Weather alloc] initWithDate:date weather:weather icon:icon]];
    }
    
    
    [self.fm close];
    
    
    if([self.delegate respondsToSelector:@selector(finishedCreateDataList:)]){
        [self.delegate finishedCreateDataList:dataList];
    }
}

#pragma mark - getWeatherInfoData
/** ライブドアのお天気APIを利用して、東京の天気予報を取得 */
- (void)getWeatherInfoData:(NSDictionary<NSString *, NSString *> *)cities {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *sql = @"INSERT OR REPLACE INTO table_weather (date, weather, icon ) VALUES(?,?,?)";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filedPath = [paths.firstObject stringByAppendingPathComponent:@"weather1.db"];
    self.fm = [[FMDatabase alloc] initWithPath:filedPath];
    
    [manager GET:weatherInfoUrl
      parameters:cities
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
             
             for (NSDictionary<NSString *, NSString *> *forecasts in responseObject[@"forecasts"]) {
                 
                 [self.fm open];
                 [self.fm executeUpdate:sql,[formatter dateFromString:forecasts[@"date"]],forecasts[@"telop"],[forecasts valueForKeyPath:@"image.url"]];
                 [self.fm close];
                 [self getDataFromDatabase];
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
         }
     ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
