//
//  TaskComponentViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/13/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskViewController.h"

@interface TaskComponentViewController : UIViewController

@property (strong, nonatomic) TaskViewController *parent;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSArray *values;
@property (weak, nonatomic) UIView *bottomBorder;
@property (weak, nonatomic) UIImageView *bottomShadow;

- (TaskComponentViewController *)initWithComponentData:(NSDictionary *)data;
- (BOOL)isCompleted;
- (NSArray *)shortcutValues;

@end
