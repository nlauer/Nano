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
    NSDictionary *appStoreLinks;
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
    
    appStoreLinks = @{@"Google Maps": @"https://itunes.apple.com/us/app/google-maps/id585027354?mt=8",
                      @"Venmo": @"https://itunes.apple.com/us/app/venmo/id351727428?mt=8",
                      @"Uber": @"https://itunes.apple.com/us/app/uber/id368677368?mt=8",
                      @"Rdio": @"https://itunes.apple.com/us/app/rdio-music/id335060889?mt=8",
                      @"Yelp": @"https://itunes.apple.com/us/app/yelp/id284910350?mt=8",
                      @"Facebook": @"https://itunes.apple.com/us/app/facebook/id284882215?mt=8",
                      @"Yo": @"https://itunes.apple.com/us/app/yo./id834335592?mt=8"};
    
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

-(BOOL)deviceHasApp {
    //TODO return whether the device has the app with self.appName
    return !appStoreLinks[self.appName];
}

-(void)openInAppStore {
    NSLog(@"should open %@", appStoreLinks[self.appName]);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLinks[self.appName]]];
}

@end
