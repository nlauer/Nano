//
//  RdioTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "RdioTaskViewController.h"
#import "Shortcut.h"
#import "ShortcutStore.h"
#import "CreateTaskViewController.h"

@interface RdioTaskViewController ()

@end

@implementation RdioTaskViewController {
    BOOL saved;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.artistField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkFields:(id)sender {
    if (self.artistField.text.length > 0) {
        [self.submitButton setHidden:NO];
    } else {
        [self.submitButton setHidden:YES];
    }
}

- (IBAction)submitButtonPressed:(id)sender {
    if (saved) {
        [self.mainVC refreshCurrentTaskForApp:@"rdio"];
    } else {
        Shortcut *shortcut = [Shortcut rdioShortcutForArtistName:self.artistField.text];
        [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
        [self.submitButton setTitle:@"Create New" forState:UIControlStateNormal];
        [self.successLabel setHidden:NO];
        saved = true;
    }
}

-(void)dismissKeyboard {
    [self.artistField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
