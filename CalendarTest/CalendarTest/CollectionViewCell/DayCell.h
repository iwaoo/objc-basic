//
//  DayCell.h
//  CalendarTest
//
//  Created by 新井岩生 on 2018/01/19.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@end
