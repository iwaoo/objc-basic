//
//  ViewController.h
//  Test
//
//  Created by 新井岩生 on 2017/12/17.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *deviceImages;
@property NSString *strImage;
@property NSUInteger pageIndex;
@property (weak, nonatomic) IBOutlet UILabel *pageIndexLabel;

@end

