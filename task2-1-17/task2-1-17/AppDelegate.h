//
//  AppDelegate.h
//  task2-1-17
//
//  Created by 新井岩生 on 2017/12/28.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

