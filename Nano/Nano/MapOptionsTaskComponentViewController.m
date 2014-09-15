//
//  MapOptionsTaskComponentViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/11/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "MapOptionsTaskComponentViewController.h"

@interface MapOptionsTaskComponentViewController ()

@end

@implementation MapOptionsTaskComponentViewController

- (MapOptionsTaskComponentViewController *)initWithComponentData:(NSDictionary *)data WithArgs:(NSArray *)args {
    self = [super initWithComponentData:data WithArgs:args];
    if( !self ) return nil;
    
    self.modes = data[@"options"];
    self.mode = data[@"defaultOption"];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttons = @[self.carButton, self.cycleButton, self.transButton, self.walkButton];
    [super loadArgs];
}

- (void)setMode:(NSString *)mode {
    [self.buttons setValue:[NSNumber numberWithBool:NO] forKey:@"selected"];
    [self.buttons[[self.modes indexOfObject:mode]] setSelected:YES];
    [self.parent rerenderButtons];
    _mode = mode;
}

- (IBAction)modeButtonPressed:(id)sender {
    [self.buttons setValue:[NSNumber numberWithBool:NO] forKey:@"selected"];
    [(UIButton *)sender setSelected:YES];
    self.mode = self.modes[[self.buttons indexOfObject:sender]];
}

@end
