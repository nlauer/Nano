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
#import "CreateTaskViewController.h"

@interface FBTaskViewController ()

@end

@implementation FBTaskViewController {
    BOOL saved;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.eventField.delegate = self;
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
    if (saved) {
        [self.mainVC refreshCurrentTaskForApp:@"fb"];
    } else {
        Shortcut *shortcut = [Shortcut facebookEventShortcutForEventID:@"" eventName:self.eventField.text];
        [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
        [self.submitButton setTitle:@"Create New" forState:UIControlStateNormal];
        [self.successLabel setHidden:NO];
        saved = true;
    }
}

-(void)dismissKeyboard {
    [self.eventField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
