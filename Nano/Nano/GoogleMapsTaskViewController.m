//
//  GoogleMapsTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "GoogleMapsTaskViewController.h"
#import "GoogleMapsTaskSearchViewController.h"
#import "Shortcut.h"
#import "ShortcutStore.h"

@interface GoogleMapsTaskViewController ()

@end

@implementation GoogleMapsTaskViewController {
    NSArray *modes;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    modes = @[@"driving", @"transit", @"bicycling", @"walking"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)submitButtonClicked:(id)sender {
    NSString *start = @"";
    NSString *end;
    NSString *mode = modes[[self.modeDropdown selectedRowInComponent:0]];
    
    if (self.startingPlace) {
        start = self.startingPlace.name;
    }
    
    if (self.endingPlace) {
        end = self.endingPlace.name;
    } else {
        // TODO throw an error
        NSLog(@"NEED ENDING PLACE");
    }

    NSURL *url = [self googleMapsURLFrom:start to:end mode:mode];
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.url = url;
    shortcut.name = [NSString stringWithFormat:@"Map to %@", self.endingPlace.name];
    shortcut.icon = @"google";
    [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
    NSLog(@"%@", url);
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return modes.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return modes[row];
}

- (NSURL *)googleMapsURLFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    return [NSURL URLWithString:[[NSString stringWithFormat:@"comgooglemaps://?saddr=%@&daddr=%@&directionsmode=%@", from, to, mode] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

@end
