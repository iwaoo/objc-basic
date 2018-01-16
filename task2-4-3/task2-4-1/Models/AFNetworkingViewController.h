//
//  AFNetworkingViewController.h
//  task2-4-1
//
//  Created by 新井岩生 on 2018/01/15.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Weather.h"

@interface AFNetworkingViewController : NSObject

/** weatherApiReCall型ブロック宣言 */
typedef void (^weatherApiReCall)(NSMutableArray<Weather *> *weatherHandler);

/** blockでコールバックしライブドアのお天気APIを利用して、東京の天気予報を取得 */
- (void)getWeatherInfoData:(NSDictionary<NSString *, NSString *> *)cities recall:(weatherApiReCall)recall;

@end

