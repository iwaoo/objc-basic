//
//  EntryViewController.h
//  task2-3-2
//
//  Created by 新井岩生 on 2017/12/21.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@end
