//
//  YoTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "YoTaskViewController.h"
#import "CreateTaskViewController.h"

@interface YoTaskViewController ()

@end

@implementation YoTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.nameField.delegate = self;
}

- (IBAction)checkFields:(id)sender {
    [self.mainVC rerenderButtons];
}

-(BOOL)shouldShowSubmit {
    return (self.nameField.text.length > 0);
}

-(Shortcut *)formShortcut {
    return [Shortcut yoShortcutForRecipient:self.nameField.text];
}

-(void)dismissKeyboard {
    [self.nameField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
