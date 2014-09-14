//
//  TaskComponentViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/13/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "TaskComponentViewController.h"

@interface TaskComponentViewController ()

@end

@implementation TaskComponentViewController

- (BOOL)isCompleted {
    return ![self.data[@"required"] boolValue] || [self performSelector:NSSelectorFromString(self.data[@"value"])];
}

- (NSString *)shortcutValue {
    if ([self performSelector:NSSelectorFromString(self.data[@"value"])]) {
        return [self performSelector:NSSelectorFromString(self.data[@"value"])];
    } else {
        return [self performSelector:NSSelectorFromString([self.data[@"value"] stringByAppendingString:@"Default"])];
    }
}

@end
