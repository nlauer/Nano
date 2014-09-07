//
//  RdioTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "RdioTaskViewController.h"
#import "Shortcut.h"
#import "ShortcutStore.h"

@interface RdioTaskViewController ()

@end

@implementation RdioTaskViewController

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
    if (self.playlistField.text.length > 0) {
        [self.submitButton setHidden:NO];
    } else {
        [self.submitButton setHidden:YES];
    }
}

- (IBAction)submitButtonPressed:(id)sender {
    Shortcut *shortcut = [Shortcut rdioShortcutForWebURLString:@"" name:self.playlistField.text];
    [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
    [self.submitButton setEnabled:NO];
}

-(void)dismissKeyboard {
    [self.playlistField resignFirstResponder];
}

@end
