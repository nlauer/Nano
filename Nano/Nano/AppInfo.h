//
//  AppInfo.h
//  Nano
//
//  Created by Jamie Karraker on 9/8/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TaskViewControllerProtocol.h"

@class CreateTaskViewController;

@interface AppInfo : NSObject

@property (strong, nonatomic) NSString *appName;
@property (strong, nonatomic) UIImage *appImage;
@property (strong, nonatomic) NSString *appAction;

-(id)initWithAppName:(NSString *)app;
-(UIViewController<TaskViewControllerProtocol> *)initializeTaskViewControllerWithMainController:(CreateTaskViewController *)mainVC;
-(BOOL)deviceHasApp;
-(void)openInAppStore;

@end
