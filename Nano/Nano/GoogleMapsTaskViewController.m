//
//  GoogleMapsTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "GoogleMapsTaskViewController.h"
#import "GoogleMapsTaskSearchViewController.h"
#import "CreateTaskViewController.h"

@interface GoogleMapsTaskViewController ()

@end

@implementation GoogleMapsTaskViewController {
    NSArray *modes;
    NSArray *buttons;
    NSString *mode;
}

- (void)viewDidLoad {
    modes = @[@"driving", @"transit", @"bicycling", @"walking"];
    buttons = @[self.carButton, self.transButton, self.cycleButton, self.walkButton];
    mode = modes[0];
}

- (IBAction)startButtonClicked:(id)sender {
    GoogleMapsTaskSearchViewController *searchController = [[GoogleMapsTaskSearchViewController alloc] init];
    searchController.isStart = true;
    searchController.parent = self;
    [self presentViewController:searchController animated:YES completion:nil];
}

- (IBAction)endButtonClicked:(id)sender {
    GoogleMapsTaskSearchViewController *searchController = [[GoogleMapsTaskSearchViewController alloc] init];
    searchController.isStart = false;
    searchController.parent = self;
    [self presentViewController:searchController animated:YES completion:nil];
}

-(Shortcut *)formShortcut {
    NSString *start = @"";
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

    return [Shortcut googleMapsShortcutFrom:start to:end mode:mode];
}

- (IBAction)modeButtonPressed:(id)sender {
    [buttons setValue:[NSNumber numberWithBool:NO] forKey:@"selected"];
    [(UIButton *)sender setSelected:YES];
    mode = modes[[buttons indexOfObject:sender]];
}

-(void)setEndingPlace:(SPGooglePlacesAutocompletePlace *)endingPlace
{
    NSLog(@"set ending place");
    _endingPlace = endingPlace;
    [self.mainVC rerenderButtons];
}

-(BOOL)shouldShowSubmit{
    
    return !!self.endingPlace;
}

@end
