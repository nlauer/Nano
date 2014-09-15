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

- (ContactTaskComponentViewController *)initWithComponentData:(NSDictionary *)data {
    self = [super initWithComponentData:data];
    if( !self ) return nil;
    
    self.leftTitle = data[@"leftTitle"];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.leftTitle;
}

- (IBAction)buttonPressed:(id)sender {
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person {
    self.firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    self.lastName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        self.phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    }
    CFRelease(phoneNumbers);
    
    ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
    if (ABMultiValueGetCount(emails) > 0) {
        self.email = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(emails, 0);
    }
    CFRelease(emails);
    
    self.contactLabel.text = [self fullName];
    [self.parent rerenderButtons];
}

// VALUES
- (NSString *)fullName {
    if (self.firstName && self.lastName) {
        return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    } else {
        return nil;
    }
}

@end
