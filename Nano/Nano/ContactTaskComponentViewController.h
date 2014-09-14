//
//  ContactTaskComponentViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/11/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TaskComponentViewController.h"

@interface ContactTaskComponentViewController : TaskComponentViewController <ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomBorder;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShadow;

@property (strong, nonatomic) NSString *leftTitle;

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *email;

@end
