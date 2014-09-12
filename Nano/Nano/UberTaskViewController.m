//
//  UberTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "UberTaskViewController.h"
#import "GoogleMapsTaskSearchViewController.h"
#import "CreateTaskViewController.h"

@interface UberTaskViewController ()

@end

@implementation UberTaskViewController

- (IBAction)startButtonClicked:(id)sender {
    GoogleMapsTaskSearchViewController *searchController = [[GoogleMapsTaskSearchViewController alloc] init];
    //searchController.isStart = true;
    searchController.parent = self;
    [self presentViewController:searchController animated:YES completion:nil];
}

- (IBAction)endButtonClicked:(id)sender {
    GoogleMapsTaskSearchViewController *searchController = [[GoogleMapsTaskSearchViewController alloc] init];
    //searchController.isStart = false;
    searchController.parent = self;
    [self.mainVC presentViewController:searchController animated:YES completion:nil];
}

-(Shortcut *)formShortcut {
    NSString *start = @"my_location";
    NSString *end;
    
    if (self.startingPlace) {
        start = self.startingPlace.name;
    }
    
    if (self.endingPlace) {
        end = self.endingPlace.name;
    } else {
        // TODO throw an error
        NSLog(@"NEED ENDING PLACE");
    }
    
    return [Shortcut uberShortcutFrom:start to:end];
}

-(void)setEndingPlace:(SPGooglePlacesAutocompletePlace *)endingPlace
{
    _endingPlace = endingPlace;
    [self.mainVC rerenderButtons];
}

-(BOOL)shouldShowSubmit{
    return !!self.endingPlace;
}

@end
