//
//  RdioTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "RdioTaskViewController.h"
#import "CreateTaskViewController.h"

@interface RdioTaskViewController ()

@end

@implementation RdioTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.artistField.delegate = self;
}

- (IBAction)checkFields:(id)sender {
    [self.mainVC rerenderButtons];
}

-(BOOL)shouldShowSubmit {
    return (self.artistField.text.length > 0);
}

-(Shortcut *)formShortcut {
    return [Shortcut rdioShortcutForArtistName:self.artistField.text];
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
