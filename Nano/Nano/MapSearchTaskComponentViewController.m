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

- (MapSearchTaskComponentViewController *)initWithComponentData:(NSDictionary *)data WithArgs:(NSArray *)args {
    self = [super initWithComponentData:data WithArgs:args];
    if( !self ) return nil;
    
    self.leftTitle = data[@"leftTitle"];
    self.searchPlaceholder = data[@"placeholder"];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.leftTitle;
    self.addressLabel.text = self.data[@"defaultAddress"];
    [super loadArgs];
}

- (void)setPlace:(SPGooglePlacesAutocompletePlace *)place {
    self.placeName = place.name;
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
- (void)setPlaceName:(NSString *)placeName {
    self.addressLabel.text = placeName;
    _placeName = placeName;
}

- (NSString *)placeNameDefault {
    return @"";
}

@end

