//
//  ViewController.h
//  task2-1-7
//
//  Created by 新井岩生 on 2017/12/11.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>
    @property (weak, nonatomic) IBOutlet UITextField *textField;
@end

