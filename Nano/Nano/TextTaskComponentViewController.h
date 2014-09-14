//
//  TextTaskComponentViewController.h
//  Nano
//
//  Created by Jamie Karraker on 9/13/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskComponentViewController.h"

@interface TextTaskComponentViewController : TaskComponentViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *bottomBorder;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShadow;

@property (strong, nonatomic) NSString *leftTitle;
@property (strong, nonatomic) NSString *text;


@end
