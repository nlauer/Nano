//
//  YelpTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompletePlace.h"

@class CreateTaskViewController;

@interface YelpTaskViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@property (nonatomic) SPGooglePlacesAutocompletePlace *endingPlace;
@property (weak, nonatomic) CreateTaskViewController *mainVC;

@end
