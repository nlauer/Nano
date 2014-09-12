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

- (UIViewController *)initWithComponentData:(NSDictionary *)data {
    self = [super init];
    if( !self ) return nil;
    
    self.data = data;
    self.modes = data[@"options"];
    self.mode = data[@"defaultOption"];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttons = @[self.carButton, self.cycleButton, self.transButton, self.walkButton];
}

- (void)setMode:(NSString *)mode {
    [self.parent rerenderButtons];
    _mode = mode;
}

- (BOOL)isCompleted {
    return self.data[@"required"] || self.mode;
}

- (NSString *)shortcutValue {
    return [self performSelector:NSSelectorFromString(self.data[@"value"])];
}

- (IBAction)modeButtonPressed:(id)sender {
    [self.buttons setValue:[NSNumber numberWithBool:NO] forKey:@"selected"];
    [(UIButton *)sender setSelected:YES];
    self.mode = self.modes[[self.buttons indexOfObject:sender]];
}

@end
