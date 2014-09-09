//
//  AppInfo.m
//  Nano
//
//  Created by Jamie Karraker on 9/8/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "AppInfo.h"
#import "GoogleMapsTaskViewController.h"
#import "UberTaskViewController.h"
#import "VenmoTaskViewController.h"
#import "YelpTaskViewController.h"
#import "IMessageTaskViewController.h"
#import "RdioTaskViewController.h"
#import "FBTaskViewController.h"
#import "YoTaskViewController.h"

@implementation AppInfo {
    NSDictionary *appImages;
    NSDictionary *appActions;
    NSDictionary *appTaskVCs;
}

-(id)initWithAppName:(NSString *)app
{
    self = [super init];
    if( !self ) return nil;
    
    appImages = @{@"Google Maps": @"gmaps",
                  @"Venmo": @"venmo",
                  @"Uber": @"uber",
                  @"Rdio": @"rdio",
                  @"Yelp": @"yelp",
                  @"Facebook": @"fb",
                  @"iMessage": @"imessage",
                  @"Yo": @"yo"};
    
    appActions = @{@"Google Maps": @"Google Maps Directions",
                   @"Venmo": @"Pay with Venmo",
                   @"Uber": @"Call an Uber",
                   @"Rdio": @"Play an Artist on Rdio",
                   @"Yelp": @"Search Nearby on Yelp",
                   @"Facebook": @"Facebook Event",
                   @"iMessage": @"Send an iMessage",
                   @"Yo": @"Send a Yo"};
    
    appTaskVCs = @{@"Google Maps": [GoogleMapsTaskViewController class],
                   @"Venmo": [VenmoTaskViewController class],
                   @"Uber": [UberTaskViewController class],
                   @"Rdio": [RdioTaskViewController class],
                   @"Yelp": [YelpTaskViewController class],
                   @"Facebook": [FBTaskViewController class],
                   @"iMessage": [IMessageTaskViewController class],
                   @"Yo": [YoTaskViewController class]};
    
    self.appName = app;
    self.appImage = [UIImage imageNamed:appImages[app]];
    self.appAction = appActions[app];
    
    return self;
}

-(UIViewController<TaskViewControllerProtocol> *)initializeTaskViewControllerWithMainController:(CreateTaskViewController *)mainVC
{
    UIViewController<TaskViewControllerProtocol> *taskVC = [[appTaskVCs[self.appName] alloc] init];
    taskVC.mainVC = mainVC;
    taskVC.saved = NO;
    return taskVC;
}

@end
