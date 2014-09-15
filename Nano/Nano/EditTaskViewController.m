//
//  EditTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/14/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "EditTaskViewController.h"
#import "ShortcutStore.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.taskVC = [[TaskViewController alloc] initWithPlistData:self.shortcut.data WithMainController:self WithArgs:self.shortcut.args];
    [self addChildViewController:self.taskVC];
    [self.containerView addSubview:self.taskVC.view];
}

- (IBAction)updateButtonClicked:(id)sender {
    self.shortcut = [self.taskVC formShortcut];
    [[ShortcutStore sharedStore] addShortcutToStore:self.shortcut];
    [self.successLabel setHidden:NO];
}

- (IBAction)deleteButtonClicked:(id)sender {
    [[ShortcutStore sharedStore] removeShortcutFromStore:self.shortcut];
}

-(void)rerenderButtons{
}

-(void)dismissKeyboard {
    [self dismissAllKeyboardsInView:self.view];
}

- (void)dismissAllKeyboardsInView:(UIView *)view {
    for (UIView *subview in [view subviews]) {
        if ([subview isMemberOfClass:[UITextField class]]) {
            [(UITextField *)subview resignFirstResponder];
        } else if ([subview isMemberOfClass:[UITextView class]]) {
            [(UITextView *)subview resignFirstResponder];
        }
        [self dismissAllKeyboardsInView:subview];
    }
}

@end
