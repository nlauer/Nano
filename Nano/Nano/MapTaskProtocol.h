//
//  MapTaskProtocol.h
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#ifndef Nano_MapTaskProtocol_h
#define Nano_MapTaskProtocol_h
#import "SPGooglePlacesAutocompletePlace.h"

@protocol MapTaskProtocol <NSObject>

@property (weak, nonatomic) UIButton *startButton;
@property (weak, nonatomic) UIButton *endButton;
@property (strong, nonatomic) SPGooglePlacesAutocompletePlace *startingPlace;
@property (strong, nonatomic) SPGooglePlacesAutocompletePlace *endingPlace;

@end

#endif
