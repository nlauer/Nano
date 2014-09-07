//
//  Shortcut.h
//  Nano
//
//  Created by Nick Lauer on 2014-09-06.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shortcut : NSObject

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *recipient;
@property NSUInteger amount;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *icon;

@end
