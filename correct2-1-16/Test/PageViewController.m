//
//  PageViewController.m
//  Test
//
//  Created by 新井岩生 on 2017/12/17.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "PageViewController.h"
#import "ViewController.h"//

@interface PageViewController ()
    @property NSArray *devices;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.devices = @[@"iPhone", @"iPad", @"iPod Touch", @"iMac", @"iWatch", @"iTv"];
    self.dataSource = self;
    
    ViewController *initiaIVC = (ViewController *)[self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initiaIVC];
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (UIViewController *) viewControllerAtIndex: (NSUInteger)index{
    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    viewController.strImage = self.devices[index];
    viewController.pageIndex = index;
    
    return viewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = ((ViewController *) viewController).pageIndex;
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((ViewController *) viewController).pageIndex;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == self.devices.count) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

@end
