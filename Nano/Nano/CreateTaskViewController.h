//
//  CreateTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "Shortcut.h"

@class TaskViewController;

@protocol TaskContainerProtocol <NSObject>

-(void)rerenderButtons;

@end

@interface CreateTaskViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, TaskContainerProtocol>
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *downloadAppButton;

@property (strong, nonatomic) TaskViewController *currentTaskVC;

@property (strong, nonatomic) NSArray *appData;
@property (strong, nonatomic) NSMutableArray *appVCs;

//temp
@property (strong, nonatomic) Shortcut *shortcut;
@end
