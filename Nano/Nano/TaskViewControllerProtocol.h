//
//  TaskViewControllerProtocol.h
//  Nano
//
//  Created by Jamie Karraker on 9/9/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#ifndef Nano_TaskViewControllerProtocol_h
#define Nano_TaskViewControllerProtocol_h
#import "Shortcut.h"

@class CreateTaskViewController;

@protocol TaskViewControllerProtocol <NSObject>

@property (strong, nonatomic) CreateTaskViewController *mainVC;
@property (nonatomic) BOOL saved;

-(Shortcut *)formShortcut;
-(BOOL)shouldShowSubmit;

@end

#endif
