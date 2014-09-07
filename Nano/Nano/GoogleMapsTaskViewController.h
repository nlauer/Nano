//
//  GoogleMapsTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SPGooglePlacesAutocompletePlace.h"

@class CreateTaskViewController;

@interface GoogleMapsTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UIButton *carButton;
@property (weak, nonatomic) IBOutlet UIButton *cycleButton;
@property (weak, nonatomic) IBOutlet UIButton *transButton;
@property (weak, nonatomic) IBOutlet UIButton *walkButton;
@property (weak, nonatomic) IBOutlet UIView *modeOptionsBar;

@property (nonatomic) SPGooglePlacesAutocompletePlace *startingPlace;
@property (nonatomic) SPGooglePlacesAutocompletePlace *endingPlace;
@property (weak, nonatomic) CreateTaskViewController *mainVC;

@end
