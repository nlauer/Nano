//
//  GoogleMapsTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompletePlace.h"
#import "TaskViewControllerProtocol.h"
#import "MapTaskProtocol.h"

@class CreateTaskViewController;

@interface GoogleMapsTaskViewController : UIViewController<TaskViewControllerProtocol, MapTaskProtocol>

@property (strong, nonatomic) CreateTaskViewController *mainVC;
@property (nonatomic) BOOL saved;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UIButton *carButton;
@property (weak, nonatomic) IBOutlet UIButton *cycleButton;
@property (weak, nonatomic) IBOutlet UIButton *transButton;
@property (weak, nonatomic) IBOutlet UIButton *walkButton;
@property (weak, nonatomic) IBOutlet UIView *modeOptionsBar;

@property (strong, nonatomic) SPGooglePlacesAutocompletePlace *startingPlace;
@property (strong, nonatomic) SPGooglePlacesAutocompletePlace *endingPlace;

@end
