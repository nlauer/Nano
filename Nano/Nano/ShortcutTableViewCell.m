//
//  ShortcutTableViewCell.m
//  Nano
//
//  Created by Jamie Karraker on 9/17/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "ShortcutTableViewCell.h"
#import "ShortcutStore.h"

@implementation ShortcutTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)enableToggled:(id)sender {
    Shortcut *oldShortcut = self.shortcut;
    if ([self.enabledSwitch isOn]) {
        self.shortcut.enabled = YES;
    } else {
        self.shortcut.enabled = NO;
    }
    [[ShortcutStore sharedStore] updateShortcutInStore:oldShortcut To:self.shortcut];
}

@end
