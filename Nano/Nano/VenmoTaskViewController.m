//
//  VenmoTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "VenmoTaskViewController.h"

@interface VenmoTaskViewController ()

@end

@implementation VenmoTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

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
    NSLog(@"%lu %lu %lu", (unsigned long)self.recipientField.text.length, (unsigned long)self.amountField.text.length, (unsigned long)self.messageField.text.length);
    if (self.recipientField.text.length > 0 &&
        self.amountField.text.length > 0 &&
        self.messageField.text.length > 0) {
        [self.submitButton setHidden:NO];
    } else {
        [self.submitButton setHidden:YES];
    }
}

- (IBAction)submitButtonClicked:(id)sender {
    // TODO send url for venmo
}

-(void)dismissKeyboard {
    [self.recipientField resignFirstResponder];
    [self.amountField resignFirstResponder];
    [self.messageField resignFirstResponder];
}

@end
