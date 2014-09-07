//
//  ShortcutStore.m
//  Nano
//
//  Created by Nick Lauer on 2014-09-06.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "ShortcutStore.h"
#import "Shortcut.h"

@interface ShortcutStore ()
@property (strong, nonatomic) NSMutableArray *shortcuts;
@end

@implementation ShortcutStore

+ (id)sharedStore
{
    static ShortcutStore *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.shortcuts = [[NSMutableArray alloc] init];
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.lauer.NanoExtension"];
        NSData *encodedObject = [sharedDefaults objectForKey:@"shortcuts"];
        self.shortcuts = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        if (self.shortcuts == nil) {
            self.shortcuts = [[NSMutableArray alloc] init];
        }
    }

    return self;
}

- (void)addShortcutToStore:(Shortcut *)shortcut
{
    [self.shortcuts addObject:shortcut];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.shortcuts];
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.lauer.NanoExtension"];
    [sharedDefaults setObject:encodedObject forKey:@"shortcuts"];
    [sharedDefaults synchronize];
}

- (void)removeShortcutFromStore:(Shortcut *)shortcut
{
    for (Shortcut *oldShortcut in self.shortcuts) {
        if ([shortcut isEqual:oldShortcut]) {
            [self.shortcuts removeObject:shortcut];
            break;
        }
    }

    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.shortcuts];
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.lauer.NanoExtension"];
    [sharedDefaults setObject:encodedObject forKey:@"shortcuts"];
    [sharedDefaults synchronize];
}

@end
