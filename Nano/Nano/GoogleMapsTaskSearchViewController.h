//
//  GoogleMapsTaskSearchViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompleteQuery.h"
#import "GoogleMapsTaskViewController.h"

@interface GoogleMapsTaskSearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate> {
    NSArray *searchResultPlaces;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    
    BOOL shouldBeginEditing;
}

@property BOOL isStart;
@property (weak, nonatomic) GoogleMapsTaskViewController *parent;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
