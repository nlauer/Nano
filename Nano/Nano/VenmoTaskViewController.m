//
//  VenmoTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "VenmoTaskViewController.h"
#import "Shortcut.h"
#import "ShortcutStore.h"

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
    if (self.recipientField.text.length > 0 &&
        self.amountField.text.length > 0 &&
        self.messageField.text.length > 0) {
        [self.submitButton setHidden:NO];
    } else {
        [self.submitButton setHidden:YES];
    }
}

- (IBAction)submitButtonClicked:(id)sender {
    NSUInteger amount = (NSUInteger)(int)roundf((CGFloat)[self.amountField.text floatValue] * 100);
    Shortcut *shortcut = [Shortcut venmoShortcutWithRecipient:self.recipientField.text amount:amount message:self.messageField.text];
    [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
    [self.submitButton setEnabled:NO];
}

-(void)dismissKeyboard {
    [self.recipientField resignFirstResponder];
    [self.amountField resignFirstResponder];
    [self.messageField resignFirstResponder];
}

@end
