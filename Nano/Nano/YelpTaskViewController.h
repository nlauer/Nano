//
//  YelpTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompletePlace.h"
#import "TaskViewControllerProtocol.h"

@class CreateTaskViewController;

@interface YelpTaskViewController : UIViewController<TaskViewControllerProtocol>

@property (strong, nonatomic) CreateTaskViewController *mainVC;
@property (nonatomic) BOOL saved;

@property (weak, nonatomic) IBOutlet UIButton *endButton;

@property (nonatomic) SPGooglePlacesAutocompletePlace *endingPlace;

@end
