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
    if (self) {
//        self.recipientField.delegate = self.mainVC;
//        self.amountField.delegate = self.mainVC;
//        self.messageField.delegate = self.mainVC;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkFields:(id)sender {
//    if (self.recipientField.text.length > 0 &&
//        self.amountField.text.length > 0 &&
//        self.messageField.text.length > 0) {
//        [self.submitButton setHidden:NO];
//    } else {
//        [self.submitButton setHidden:YES];
//    }
}

- (IBAction)submitButtonClicked:(id)sender {
    // TODO send url for venmo
}

@end
