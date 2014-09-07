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
#import "Shortcut.h"
#import "ShortcutStore.h"

@interface YelpTaskViewController ()

@end

@implementation YelpTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)endButtonClicked:(id)sender {
    GoogleMapsTaskSearchViewController *searchController = [[GoogleMapsTaskSearchViewController alloc] init];
    searchController.isStart = false;
    searchController.parent = self;
    [self.mainVC presentViewController:searchController animated:YES completion:nil];
}

- (IBAction)submitButtonClicked:(id)sender {
    NSString *end;
    
    if (self.endingPlace) {
        end = self.endingPlace.name;
    } else {
        // TODO throw an error
        NSLog(@"NEED ENDING PLACE");
    }
    
    Shortcut *shortcut = [Shortcut yelpShortcutForSearch:self.endingPlace.name];
    [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
    [self.submitButton setEnabled:NO];
}

@end
