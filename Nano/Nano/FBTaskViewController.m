//
//  FBTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "FBTaskViewController.h"
#import "Shortcut.h"
#import "ShortcutStore.h"

@interface FBTaskViewController ()

@end

@implementation FBTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkFields:(id)sender {
    if (self.eventField.text.length > 0) {
        [self.submitButton setHidden:NO];
    } else {
        [self.submitButton setHidden:YES];
    }
}

- (IBAction)submitButtonPressed:(id)sender {
    Shortcut *shortcut = [Shortcut facebookEventShortcutForEventID:@"" eventName:self.eventField.text];
    [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
    [self.submitButton setEnabled:NO];
}

-(void)dismissKeyboard {
    [self.eventField resignFirstResponder];
}

@end
