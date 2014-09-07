//
//  IMessageTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "IMessageTaskViewController.h"
#import "Shortcut.h"
#import "ShortcutStore.h"

@interface IMessageTaskViewController ()

@end

@implementation IMessageTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.recipientField.delegate = self;
    self.nameField.delegate = self;
    self.messageField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)checkFields:(id)sender {
    if (self.recipientField.text.length > 0 &&
        self.nameField.text.length > 0 &&
        self.messageField.text.length > 0) {
        [self.submitButton setHidden:NO];
    } else {
        [self.submitButton setHidden:YES];
    }
}

- (IBAction)submitButtonPressed:(id)sender {
    Shortcut *shortcut = [Shortcut smsShortcutForNumber:self.recipientField.text name:self.nameField.text];
    [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
    [self.submitButton setEnabled:NO];
}

-(void)dismissKeyboard {
    [self.recipientField resignFirstResponder];
    [self.nameField resignFirstResponder];
    [self.messageField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
