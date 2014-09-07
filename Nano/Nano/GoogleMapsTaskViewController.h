//
//  GoogleMapsTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompleteQuery.h"

@interface GoogleMapsTaskViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *startSearchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *endSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *startResultsTableView;
@property (weak, nonatomic) IBOutlet UITableView *endResultsTableView;

@property (weak, nonatomic) NSArray *searchResultPlaces;
@property (strong, nonatomic) SPGooglePlacesAutocompleteQuery *searchQuery;

@property (nonatomic) BOOL shouldBeginEditing;

@end
