//
//  OverlayView.h
//  Test
//
//  Created by 新井岩生 on 2017/12/12.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverlayView : UIView
    @property(nonatomic, weak) id target;
    @property(nonatomic, assign) SEL action;
@end
