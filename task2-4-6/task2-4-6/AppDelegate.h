//
//  AppDelegate.h
//  task2-4-6
//
//  Created by 新井岩生 on 2018/01/04.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

