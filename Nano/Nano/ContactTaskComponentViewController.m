//
//  ContactTaskComponentViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/11/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "ContactTaskComponentViewController.h"

@interface ContactTaskComponentViewController ()

@end

@implementation ContactTaskComponentViewController

- (UIViewController *)initWithComponentData:(NSDictionary *)data {
    self = [super init];
    if( !self ) return nil;
    
    self.data = data;
    self.leftTitle = data[@"leftTitle"];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.leftTitle;
}

- (void) setPerson:(ABRecordRef)person {
    self.contactLabel.text = [self fullNameForPerson:person];
    _person = person;
    [self.parent rerenderButtons];
}

- (BOOL)isCompleted {
    return self.data[@"required"] || self.person;
}

- (NSString *)shortcutValue {
    return [self performSelector:NSSelectorFromString(self.data[@"value"])];
}

- (IBAction)buttonPressed:(id)sender {
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (NSString *)phoneNumberForPerson:(ABRecordRef)person {
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        NSLog(@"No Phone number!");
    }
    CFRelease(phoneNumbers);
    return phone;
}

- (NSString *)fullNameForPerson:(ABRecordRef)person {
    NSString* firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lastName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
}

- (NSString *)fullName {
    return [self fullNameForPerson:self.person];
}

- (NSString *)phoneNumber {
    return [self phoneNumberForPerson:self.person];
}

#pragma mark ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person {
    self.person = person;
}

@end
