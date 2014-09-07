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
#import "Shortcut.h"
#import "ShortcutStore.h"

@interface GoogleMapsTaskViewController ()

@end

@implementation GoogleMapsTaskViewController {
    NSArray *modes;
    NSArray *buttons;
    NSString *mode;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.modeOptionsBar.bounds];
        self.modeOptionsBar.layer.masksToBounds = NO;
        self.modeOptionsBar.layer.shadowColor = [UIColor blackColor].CGColor;
        self.modeOptionsBar.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
        self.modeOptionsBar.layer.shadowOpacity = 0.5f;
        self.modeOptionsBar.layer.shadowPath = shadowPath.CGPath;
    }
    return self;
}

- (void)viewDidLoad {
    modes = @[@"driving", @"transit", @"bicycling", @"walking"];
    buttons = @[self.carButton, self.transButton, self.cycleButton, self.walkButton];
    mode = modes[0];
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
    [self.mainVC presentViewController:searchController animated:YES completion:nil];
}

- (IBAction)submitButtonClicked:(id)sender {
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

    NSURL *url = [self googleMapsURLFrom:start to:end mode:mode];
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.url = url;
    shortcut.name = [NSString stringWithFormat:@"Map to %@", self.endingPlace.name];
    shortcut.icon = @"google";
    [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
    NSLog(@"%@", url);
}

- (IBAction)modeButtonPressed:(id)sender {
    [buttons setValue:[NSNumber numberWithBool:NO] forKey:@"selected"];
    [(UIButton *)sender setSelected:YES];
    mode = modes[[buttons indexOfObject:sender]];
}

- (NSURL *)googleMapsURLFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    return [NSURL URLWithString:[[NSString stringWithFormat:@"comgooglemaps://?saddr=%@&daddr=%@&directionsmode=%@", from, to, mode] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

@end
