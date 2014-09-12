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
    [self setTitleLabelText:self.leftTitle];
    self.addressLabel.text = self.data[@"defaultAddress"];
}

- (void)setPlace:(SPGooglePlacesAutocompletePlace *)place {
    self.addressLabel.text = place.name;
    _place = place;
    [self.parent rerenderButtons];
}

- (BOOL)isCompleted {
    return ![self.data[@"required"] boolValue] || self.place;
}

- (NSString *)shortcutValue {
    return [self performSelector:NSSelectorFromString(self.data[@"value"])];
}

- (IBAction)buttonPressed:(id)sender {
    GoogleMapsTaskSearchViewController *searchController = [[GoogleMapsTaskSearchViewController alloc] init];
    searchController.parent = self;
    searchController.placeholder = self.searchPlaceholder;
    [self presentViewController:searchController animated:YES completion:nil];
}

- (void)setTitleLabelText:(NSString *)text {
    self.titleLabel.text = text;
    NSDictionary *attributesDictionary = @{self.titleLabel.font: NSFontAttributeName};
    CGRect frame = [self.titleLabel.text boundingRectWithSize:self.view.frame.size
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributesDictionary
                                            context:nil];
    CGSize size = frame.size;
    self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, size.width, self.titleLabel.frame.size.height);
    int newAddressX = self.titleLabel.frame.origin.x + size.width + 8;
    int newAddressWidth = self.addressLabel.frame.origin.x + self.addressLabel.frame.size.width - newAddressX;
    self.addressLabel.frame = CGRectMake(newAddressX, self.addressLabel.frame.origin.y, newAddressWidth, self.addressLabel.frame.size.height);
}

- (NSString *)placeName {
    if (self.place) {
        return self.place.name;
    } else {
        return @"";
    }
}

@end

