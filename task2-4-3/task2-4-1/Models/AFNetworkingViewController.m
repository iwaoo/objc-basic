//
//  AFNetworkingViewController.m
//  task2-4-1
//
//  Created by 新井岩生 on 2018/01/15.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "AFNetworkingViewController.h"

// JSONデータをリクエストする際のベースとなるURL
static NSString *const weatherInfoUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1";

@implementation AFNetworkingViewController
/** blockでコールバックしライブドアのお天気APIを利用して、東京の天気予報を取得 */
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

@end
