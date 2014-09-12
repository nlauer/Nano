//
//  TaskComponentViewControllerProtocol.h
//  Nano
//
//  Created by Jamie Karraker on 9/12/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#ifndef Nano_TaskComponentViewControllerProtocol_h
#define Nano_TaskComponentViewControllerProtocol_h
#import <UIKit/UIKit.h>
#import "TaskViewController.h"

@protocol TaskComponentViewControllerProtocol <NSObject>

@property (strong, nonatomic) NSDictionary *data;

@property TaskViewController *parent;

- (UIViewController *)initWithComponentData:(NSDictionary *)data;
- (BOOL)isCompleted;
- (NSString *)shortcutValue;

@end

#endif
