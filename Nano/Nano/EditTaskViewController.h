//
//  EditTaskViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/14/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateTaskViewController.h"
#import "TaskViewController.h"
#import "Shortcut.h"

@interface EditTaskViewController : UIViewController<TaskContainerProtocol>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (strong, nonatomic) TaskViewController *taskVC;
@property (strong, nonatomic) Shortcut *shortcut;

@end
