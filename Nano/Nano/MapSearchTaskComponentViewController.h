//
//  MapSearchTaskComponentViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/12/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompletePlace.h"
#import "TaskComponentViewController.h"

@interface MapSearchTaskComponentViewController : TaskComponentViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomBorder;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShadow;

@property (strong, nonatomic) NSString *leftTitle;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *searchPlaceholder;
@property (strong, nonatomic) SPGooglePlacesAutocompletePlace *place;

// VALUES
@property (strong, nonatomic) NSString *placeName;

@end
