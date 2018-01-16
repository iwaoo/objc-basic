//
//  OverlayView.m
//  Test
//
//  Created by 新井岩生 on 2017/12/12.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "OverlayView.h"

@implementation OverlayView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.target performSelector:self.action withObject:self afterDelay:0.0f];
}

@end
