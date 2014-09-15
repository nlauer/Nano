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
    return [Shortcut smsShortcutForNumber:self.recipientField.text name:self.nameField.text message:nil];
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

- (IBAction)showContactsPicker:(id)sender {
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    NSLog(@"cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person {
    NSString* firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lastName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    CFRelease(phoneNumbers);
    NSLog(@"Picked person %@ %@, %@", firstName, lastName, phone);
}

- (void)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    NSLog(@"Picked person %@ with property %d and identifier %d", person, property, identifier);
}


@end
