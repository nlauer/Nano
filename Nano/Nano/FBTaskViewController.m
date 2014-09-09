//
//  FBTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "FBTaskViewController.h"
#import "CreateTaskViewController.h"

@interface FBTaskViewController ()

@end

@implementation FBTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.eventField.delegate = self;
}

- (IBAction)checkFields:(id)sender {
    [self.mainVC rerenderButtons];
}

-(BOOL)shouldShowSubmit {
    return (self.eventField.text.length > 0);
}

-(Shortcut *)formShortcut {
    return [Shortcut facebookEventShortcutForEventID:@"" eventName:self.eventField.text];
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
