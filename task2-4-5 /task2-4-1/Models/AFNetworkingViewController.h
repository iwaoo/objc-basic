//
//  AFNetworkingViewController.h
//  task2-4-1
//
//  Created by 新井岩生 on 2018/01/12.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol AFNetworkingViewControllerDelegate <NSObject>
-(void)finishedCreateDataList:(NSMutableArray *)dataList;
@end

@interface AFNetworkingViewController : UIViewController

@property (nonatomic,weak) id<AFNetworkingViewControllerDelegate> delegate;

- (void)getWeatherInfoData:(NSDictionary<NSString *, NSString *> *)cities;

@end





