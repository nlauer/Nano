//
//  Shortcut.m
//  Nano
//
//  Created by Nick Lauer on 2014-09-06.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "Shortcut.h"

@implementation Shortcut

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.recipient forKey:@"recipient"];
    [encoder encodeObject:self.icon forKey:@"icon"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:[NSNumber numberWithInt:self.amount] forKey:@"amount"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.url = [decoder decodeObjectForKey:@"url"];
        self.recipient = [decoder decodeObjectForKey:@"recipient"];
        self.icon = [decoder decodeObjectForKey:@"icon"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.amount = [[decoder decodeObjectForKey:@"amount"] integerValue];
    }
    return self;
}

@end
