//
//  GoogleMapsTaskSearchViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompleteQuery.h"
#import "MapSearchTaskComponentViewController.h"

@interface GoogleMapsTaskSearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) MapSearchTaskComponentViewController *parent;
@property (strong, nonatomic) NSString *placeholder;

@end
