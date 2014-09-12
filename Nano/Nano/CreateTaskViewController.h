//
//  CreateTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "TaskViewController.h"

@interface CreateTaskViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *submitView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *createNewButton;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadAppButton;

@property (strong, nonatomic) TaskViewController *currentTaskVC;

@property (strong, nonatomic) NSArray *appData;
@property (strong, nonatomic) NSMutableArray *appVCs;

-(void)rerenderButtons;

@end
