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

@interface ViewController ()
    // weatherApiReCall型ブロック宣言
    typedef void (^weatherApiReCall)(NSMutableArray<Weather *> *weatherHandler);

@end

static NSString *const weatherInfoUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1";

@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)actionSheetBtnEnter:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"選択" message:@"どの日の天気を知りたいですか？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // ボタンを配置
    [alertController addAction:[UIAlertAction actionWithTitle:@"今日" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectedActionWith:0];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"明日" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectedActionWith:1];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"明後日" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectedActionWith:2];
    }]];
    
    alertController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:alertController animated:YES completion:nil];
}
    
-(void)selectedActionWith:(int)index{
    NSDictionary<NSString *, NSString *> *cities = @{@"city" : @"130010"};
    [self getWeatherInfoData:cities recall:^(NSMutableArray<Weather *> *weatherHandler) {
        NSLog(@"%@の天気は%@です。", weatherHandler[index].dateLabel, weatherHandler[index].telop);
    }];
}
// blockでコールバック
- (void)getWeatherInfoData:(NSDictionary<NSString *, NSString *> *)cities recall:(weatherApiReCall)recall {
    NSMutableArray *weatherHandler = [NSMutableArray new];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:weatherInfoUrl
      parameters:cities
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
             
             for (NSDictionary<NSString *, NSString *> *forecasts in responseObject[@"forecasts"]) {
                 Weather *weather = [Weather new];
                 weather.dateLabel = forecasts[@"dateLabel"];
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
