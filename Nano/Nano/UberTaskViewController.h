//
//  UberTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SPGooglePlacesAutocompletePlace.h"

@class CreateTaskViewController;

@interface UberTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@property (nonatomic) SPGooglePlacesAutocompletePlace *startingPlace;
@property (nonatomic) SPGooglePlacesAutocompletePlace *endingPlace;
@property (weak, nonatomic) CreateTaskViewController *mainVC;

@end
