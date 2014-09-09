//
//  VenmoTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "VenmoTaskViewController.h"
#import "CreateTaskViewController.h"

@interface VenmoTaskViewController ()

@end

@implementation VenmoTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.recipientField.delegate = self;
    self.amountField.delegate = self;
    self.messageField.delegate = self;
}

- (IBAction)checkFields:(id)sender {
    [self.mainVC rerenderButtons];
}

-(BOOL)shouldShowSubmit {
    return (self.recipientField.text.length > 0 &&
            self.amountField.text.length > 0 &&
            self.messageField.text.length > 0);
}

-(Shortcut *)formShortcut {
    NSUInteger amount = (NSUInteger)(int)roundf((CGFloat)[self.amountField.text floatValue] * 100);
    return [Shortcut venmoShortcutWithRecipient:self.recipientField.text amount:amount message:self.messageField.text];
}

-(void)dismissKeyboard {
    [self.recipientField resignFirstResponder];
    [self.amountField resignFirstResponder];
    [self.messageField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
