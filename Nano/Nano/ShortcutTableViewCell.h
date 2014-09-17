//
//  ShortcutTableViewCell.h
//  Nano
//
//  Created by Jamie Karraker on 9/17/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShortcutTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (weak, nonatomic) IBOutlet UISwitch *enabledSwitch;

@end
