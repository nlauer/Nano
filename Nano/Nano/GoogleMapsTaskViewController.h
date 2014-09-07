//
//  GoogleMapsTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompletePlace.h"

@interface GoogleMapsTaskViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UIPickerView *modeDropdown;

@property (nonatomic) SPGooglePlacesAutocompletePlace *startingPlace;
@property (nonatomic) SPGooglePlacesAutocompletePlace *endingPlace;

@end
