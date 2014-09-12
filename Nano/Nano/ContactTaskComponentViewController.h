//
//  ContactTaskComponentViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/11/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TaskComponentViewControllerProtocol.h"

@interface ContactTaskComponentViewController : UIViewController <TaskComponentViewControllerProtocol, ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomBorder;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShadow;

@property TaskViewController *parent;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSString *leftTitle;
@property (strong, nonatomic) NSString *contactName;
@property (nonatomic) ABRecordRef person;

@end
