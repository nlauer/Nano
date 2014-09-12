//
//  IMessageTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskViewControllerProtocol.h"
#import <AddressBookUI/AddressBookUI.h>

@class CreateTaskViewController;

@interface IMessageTaskViewController : UIViewController <UITextFieldDelegate, TaskViewControllerProtocol, ABPeoplePickerNavigationControllerDelegate>

@property (strong, nonatomic) CreateTaskViewController *mainVC;
@property (nonatomic) BOOL saved;

@property (weak, nonatomic) IBOutlet UITextField *recipientField;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
