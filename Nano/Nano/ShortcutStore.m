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
            [self addShortcutToStore:[self venmoShortcutForRecipient:@"jlauer" amount:1]];
            [self addShortcutToStore:[self facebookEventShortcutForEventID:@"620819504700967"]];
            [self addShortcutToStore:[self smsShortcutForNumber:@"4159351717"]];
            [self addShortcutToStore:[self yelpShortcutForSearch:@"Starbucks"]];
            [self addShortcutToStore:[self uberShortcutForDestination:@"555 W. Middlefield Road"]];
            [self addShortcutToStore:[self rdioShortcutForCodingMix]];
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

#pragma mark - Custom Actions

- (Shortcut *)venmoShortcutForRecipient:(NSString *)recipient amount:(NSUInteger)amount
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Pay Josh $0.01";
    shortcut.amount = amount;
    shortcut.recipient = recipient;
    shortcut.icon = @"venmo";

    return shortcut;
}

- (Shortcut *)googleMapsShortcutFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Transit Home";
    shortcut.icon = @"google";
    shortcut.url = [self googleMapsURLFrom:from to:to mode:mode];

    return shortcut;
}

- (NSURL *)googleMapsURLFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?saddr=%@&daddr=%@&directionsmode=%@", from, to, mode]];
}

- (Shortcut *)facebookEventShortcutForEventID:(NSString *)eventID
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"TechCrunch Disrupt Event";
    shortcut.icon = @"fb";
    shortcut.url = [self facebookEventURLForEventID:eventID];

    return shortcut;
}

- (NSURL *)facebookEventURLForEventID:(NSString *)eventID
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"fb://event?id=%@", eventID]];
}

- (Shortcut *)smsShortcutForNumber:(NSString *)number
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Text Message Josh";
    shortcut.icon = @"imessage";
    shortcut.url = [self smsURLForPhoneNumber:number];

    return shortcut;
}

- (NSURL *)smsURLForPhoneNumber:(NSString *)number
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", number]];
}

- (Shortcut *)yelpShortcutForSearch:(NSString *)search
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Search Yelp for Starbucks";
    shortcut.icon = @"yelp";
    shortcut.url = [self yelpSearchForName:search];

    return shortcut;
}

- (NSURL *)yelpSearchForName:(NSString *)name
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"yelp:///search?terms=%@", name]];
}

- (Shortcut *)uberShortcutForDestination:(NSString *)search
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Uber Home";
    shortcut.icon = @"uber";
    shortcut.url = [NSURL URLWithString:[NSString stringWithFormat:@"uber://"]];

    return shortcut;
}

- (Shortcut *)rdioShortcutForCodingMix
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Listen to Coding Mix";
    shortcut.icon = @"rdio";
    shortcut.url = [NSURL URLWithString:[NSString stringWithFormat:@"rdio://www.rdio.com/people/dvos/playlists/1127421/Coding_Mix/"]];
    
    return shortcut;
}


@end
