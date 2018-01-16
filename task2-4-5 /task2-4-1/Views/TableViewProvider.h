//
//  TableViewProvider.h
//  task2-4-1
//
//  Created by 新井岩生 on 2018/01/15.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Weather.h"
@interface TableViewProvider : NSObject<UITableViewDataSource>
@property NSMutableArray<Weather *> *dataList;
@end
