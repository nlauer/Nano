//
//  ShortcutTableViewCell.m
//  Nano
//
//  Created by Jamie Karraker on 9/17/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "ShortcutTableViewCell.h"

@implementation ShortcutTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)enableToggled:(id)sender {
    if ([self.enabledSwitch isOn]) {
        // add shortcut to store
    } else {
        // remove shortcut from store
    }
}

@end
