//
//  MapSearchTaskComponentViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/12/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompletePlace.h"
#import "TaskComponentViewControllerProtocol.h"

@interface MapSearchTaskComponentViewController : UIViewController<TaskComponentViewControllerProtocol>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomBorder;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShadow;

@property TaskViewController *parent;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSString *leftTitle;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *searchPlaceholder;
@property (strong, nonatomic) SPGooglePlacesAutocompletePlace *place;

@end
