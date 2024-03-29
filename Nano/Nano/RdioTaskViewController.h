//
//  RdioTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskViewControllerProtocol.h"

@class CreateTaskViewController;

@interface RdioTaskViewController : UIViewController <UITextFieldDelegate, TaskViewControllerProtocol>

@property (strong, nonatomic) CreateTaskViewController *mainVC;
@property (nonatomic) BOOL saved;

@property (weak, nonatomic) IBOutlet UITextField *artistField;

@end
