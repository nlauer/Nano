//
//  MapOptionsTaskComponentViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/11/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskComponentViewControllerProtocol.h"

@interface MapOptionsTaskComponentViewController : UIViewController<TaskComponentViewControllerProtocol>

@property (weak, nonatomic) IBOutlet UIView *bottomBorder;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShadow;
@property (weak, nonatomic) IBOutlet UIButton *carButton;
@property (weak, nonatomic) IBOutlet UIButton *cycleButton;
@property (weak, nonatomic) IBOutlet UIButton *transButton;
@property (weak, nonatomic) IBOutlet UIButton *walkButton;

@property TaskViewController *parent;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSArray *modes;
@property (strong, nonatomic) NSArray *buttons;
@property (strong, nonatomic) NSString *mode;

@end
