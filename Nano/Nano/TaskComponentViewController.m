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

- (TaskComponentViewController *)initWithComponentData:(NSDictionary *)data WithArgs:(NSArray *)args {
    self = [super init];
    if( !self ) return nil;
    
    self.data = data;
    self.args = args;
    self.values = data[@"values"];
    
    return self;
}

- (void)loadArgs {
    if (self.args) {
        for (int i = 0; i < self.values.count; i++) {
            NSString *arg = self.args[i];
            if (![arg isEqual:[NSNull null]]) {
                NSString *setter = [NSString stringWithFormat:@"set%@%@:",[[self.values[i][@"value"] substringToIndex:1] uppercaseString],[self.values[i][@"value"] substringFromIndex:1]];
                [self performSelector:NSSelectorFromString(setter) withObject:arg];
            }
        }
    }
}

- (BOOL)isCompleted {
    BOOL isCompleted = YES;
    for (NSDictionary *dict in self.values) {
        isCompleted = isCompleted &&
            (![dict[@"required"] boolValue]
             || [self performSelector:NSSelectorFromString(dict[@"value"])]);
    }
    return isCompleted;
}

- (NSArray *)shortcutValues {
    NSMutableArray *shortcutValues = [[NSMutableArray alloc] initWithCapacity:self.values.count];
    for (NSDictionary *dict in self.values) {
        if ([self performSelector:NSSelectorFromString(dict[@"value"])]) {
            [shortcutValues addObject:[self performSelector:NSSelectorFromString(dict[@"value"])]];
        } else if ([dict[@"required"] boolValue]) {
            [shortcutValues addObject:[self performSelector:NSSelectorFromString([dict[@"value"] stringByAppendingString:@"Default"])]];
        } else {
            [shortcutValues addObject:[NSNull null]];
        }
    }
    return shortcutValues;
}

@end
