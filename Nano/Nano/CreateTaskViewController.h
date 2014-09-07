//
//  CreateTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "GoogleMapsTaskViewController.h"
#import "UberTaskViewController.h"
#import "VenmoTaskViewController.h"
#import "YelpTaskViewController.h"
#import "IMessageTaskViewController.h"

@interface CreateTaskViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) GoogleMapsTaskViewController *googleVC;
@property (strong, nonatomic) UberTaskViewController *uberVC;
@property (strong, nonatomic) VenmoTaskViewController *venmoVC;
@property (strong, nonatomic) YelpTaskViewController *yelpVC;
@property (strong, nonatomic) IMessageTaskViewController *imessageVC;
@property (strong, nonatomic) UIViewController *taskVC;

@end
