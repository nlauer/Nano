//
//  IMessageTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "IMessageTaskViewController.h"
#import "CreateTaskViewController.h"

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

- (IBAction)checkFields:(id)sender {
    [self.mainVC rerenderButtons];
}

-(BOOL)shouldShowSubmit {
    return (self.recipientField.text.length > 0 &&
            self.nameField.text.length > 0 &&
            self.messageField.text.length > 0);
}

-(Shortcut *)formShortcut {
    return [Shortcut smsShortcutForNumber:self.recipientField.text name:self.nameField.text];
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
