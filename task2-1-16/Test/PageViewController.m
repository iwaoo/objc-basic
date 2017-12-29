//
//  PageViewController.m
//  Test
//
//  Created by 新井岩生 on 2017/12/18.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "PageViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface PageViewController ()
{
    FirstViewController *firstViewController;
    SecondViewController *secondViewController;
    ThirdViewController *thirdViewController;
    UIViewController *nextViewController;
}

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = self;
    self.delegate = self;
    [self setViewControllers:@[[self getFirstViewController]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (FirstViewController *) getFirstViewController{
    firstViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    return firstViewController;
}
- (SecondViewController *) getSecondViewController{

    secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    return secondViewController;
}
- (ThirdViewController *) getThirdViewController{
    thirdViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdViewController"];
    return thirdViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = viewController.view.tag;
    if (index == 3) {
        nextViewController = [self getSecondViewController];
    } else if (index == 2) {
        nextViewController = [self getFirstViewController];
    } else if(index == 1) {
        nextViewController = nil;
    }
    return nextViewController;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController

{
    NSUInteger index = viewController.view.tag;
    if (index == 1) {
        nextViewController = [self getSecondViewController];
    } else if (index == 2) {
        nextViewController = [self getThirdViewController];
    } else if(index == 3) {
        nextViewController = nil;
    }
    return nextViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
