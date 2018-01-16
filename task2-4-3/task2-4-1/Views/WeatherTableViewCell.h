//
//  WeatherTableViewCell.h
//  task2-4-1
//
//  Created by 新井岩生 on 2018/01/15.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *telop;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageUrl;
@end
