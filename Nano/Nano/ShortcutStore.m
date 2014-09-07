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
            [self addShortcutToStore:[Shortcut facebookEventShortcutForEventID:@"620819504700967" eventName:@"TechCrunch Disrupt Hackathon"]];
            [self addShortcutToStore:[Shortcut yelpShortcutForSearch:@"Starbucks"]];
            [self addShortcutToStore:[Shortcut rdioShortcutForArtistName:@"The_Head_and_the_Heart"]];
            [self addShortcutToStore:[Shortcut yoShortcutForRecipient:@"jlauer"]];
            [self addShortcutToStore:[Shortcut uberShortcutFrom:@"" to:@"Home"]];
//            [self addShortcutToStore:[Shortcut venmoShortcutWithRecipient:@"jlauer" amount:1 message:@"payback"]];
            [self addShortcutToStore:[Shortcut smsShortcutForNumber:@"4159351717" name:@"Josh Lauer"]];
        }
    }

    return self;
}

- (void)addShortcutToStore:(Shortcut *)shortcut
{
    [self.shortcuts insertObject:shortcut atIndex:0];
    if (self.shortcuts.count > 8) {
        [self.shortcuts removeLastObject];
    }
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
