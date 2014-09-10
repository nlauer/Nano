//
//  YelpTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "YelpTaskViewController.h"
#import "GoogleMapsTaskSearchViewController.h"
#import "CreateTaskViewController.h"

@interface YelpTaskViewController ()

@end

@implementation YelpTaskViewController 

- (IBAction)endButtonClicked:(id)sender {
    GoogleMapsTaskSearchViewController *searchController = [[GoogleMapsTaskSearchViewController alloc] init];
    searchController.isStart = false;
    searchController.parent = self;
    [self presentViewController:searchController animated:YES completion:nil];
}

-(Shortcut *)formShortcut {
    NSString *end;
    
    if (self.endingPlace) {
        end = self.endingPlace.name;
    } else {
        // TODO throw an error
        NSLog(@"NEED ENDING PLACE");
    }
    
    return [Shortcut yelpShortcutForSearch:self.endingPlace.name];
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
