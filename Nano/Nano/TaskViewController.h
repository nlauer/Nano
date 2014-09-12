//
//  TaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/11/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shortcut.h"

@class CreateTaskViewController;

@interface TaskViewController : UIViewController

@property (strong, nonatomic) CreateTaskViewController *mainVC;
@property (nonatomic) BOOL saved;
@property (strong, nonatomic) NSString *appName;
@property (strong, nonatomic) NSString *action;
@property (strong, nonatomic) NSArray *components;
@property (strong, nonatomic) NSString *shortcutSelectorString;
@property (strong, nonatomic) NSString *urlScheme;
@property (strong, nonatomic) NSString *appStoreLink;
@property (strong, nonatomic) UIImage *appImage;
@property (strong, nonatomic) NSMutableArray *componentVCs;

-(TaskViewController *)initWithPlistData:(NSDictionary *)data WithMainController:(CreateTaskViewController *)mainVC;
-(Shortcut *)formShortcut;
-(BOOL)shouldShowSubmit;
-(BOOL)deviceHasApp;
-(void)openInAppStore;
-(void)rerenderButtons;

@end
