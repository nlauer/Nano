//
//  CreateTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "TaskViewControllerProtocol.h"

@interface CreateTaskViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *submitView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *createNewButton;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@property (strong, nonatomic) UIViewController<TaskViewControllerProtocol> *taskVC;

@property (strong, nonatomic) NSArray *appNames;
@property (strong, nonatomic) NSDictionary *appInfos;
@property (strong, nonatomic) NSMutableDictionary *appVCs;

-(void)rerenderButtons;

@end
