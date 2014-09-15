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

- (TaskComponentViewController *)initWithComponentData:(NSDictionary *)data {
    self = [super init];
    if( !self ) return nil;
    
    self.data = data;
    self.values = data[@"values"];
    
    return self;
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
        } else {
            [shortcutValues addObject:[self performSelector:NSSelectorFromString([dict[@"value"] stringByAppendingString:@"Default"])]];
        }
    }
    return shortcutValues;
}

@end
