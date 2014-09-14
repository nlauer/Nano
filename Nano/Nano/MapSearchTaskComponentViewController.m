//
//  MapSearchTaskComponentViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/12/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "MapSearchTaskComponentViewController.h"
#import "GoogleMapsTaskSearchViewController.h"

@interface MapSearchTaskComponentViewController ()

@end

@implementation MapSearchTaskComponentViewController

- (UIViewController *)initWithComponentData:(NSDictionary *)data {
    self = [super init];
    if( !self ) return nil;
    
    self.data = data;
    self.leftTitle = data[@"leftTitle"];
    self.searchPlaceholder = data[@"placeholder"];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.leftTitle;
    self.addressLabel.text = self.data[@"defaultAddress"];
}

- (void)setPlace:(SPGooglePlacesAutocompletePlace *)place {
    self.addressLabel.text = place.name;
    _place = place;
    [self.parent rerenderButtons];
}

- (IBAction)buttonPressed:(id)sender {
    GoogleMapsTaskSearchViewController *searchController = [[GoogleMapsTaskSearchViewController alloc] init];
    searchController.parent = self;
    searchController.placeholder = self.searchPlaceholder;
    [self presentViewController:searchController animated:YES completion:nil];
}

// VALUES
- (NSString *)placeName {
    if (self.place) {
        return self.place.name;
    } else {
        return nil;
    }
}

- (NSString *)placeNameDefault {
    return @"";
}

@end

