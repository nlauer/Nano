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
#import "Shortcut.h"
#import "ShortcutStore.h"

@interface UberTaskViewController ()

@end

@implementation UberTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEndingPlace:(SPGooglePlacesAutocompletePlace *)endingPlace
{
    [self.submitButton setHidden:NO];
    _endingPlace = endingPlace;
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
    [self.mainVC presentViewController:searchController animated:YES completion:nil];
}

- (IBAction)submitButtonClicked:(id)sender {
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
    
    Shortcut *shortcut = [Shortcut uberShortcutFrom:start to:end];
    [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
    [self.submitButton setEnabled:NO];
}


@end
