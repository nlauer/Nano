//
//  UberTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompletePlace.h"
#import "TaskViewControllerProtocol.h"
#import "MapTaskProtocol.h"

@class CreateTaskViewController;

@interface UberTaskViewController : UIViewController<TaskViewControllerProtocol, MapTaskProtocol>

@property (strong, nonatomic) CreateTaskViewController *mainVC;
@property (nonatomic) BOOL saved;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;

@property (strong, nonatomic) SPGooglePlacesAutocompletePlace *startingPlace;
@property (strong, nonatomic) SPGooglePlacesAutocompletePlace *endingPlace;

@end
