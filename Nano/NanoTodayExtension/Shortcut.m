//
//  Shortcut.m
//  Nano
//
//  Created by Nick Lauer on 2014-09-06.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "Shortcut.h"

@implementation Shortcut

+ (Shortcut *)venmoShortcutWithRecipient:(NSString *)recipient amount:(NSUInteger)amount message:(NSString *)message
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.recipient = recipient;
    shortcut.amount = amount;
    shortcut.message = message;
    shortcut.name = [NSString stringWithFormat:@"Pay %@", recipient];
    shortcut.icon = @"venmo";

    return shortcut;
}

+ (Shortcut *)googleMapsShortcutFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = [NSString stringWithFormat:@"%@ to %@", [mode capitalizedString], to];
    shortcut.icon = @"google";
    shortcut.url = [self googleMapsURLFrom:from to:to mode:mode];

    return shortcut;
}

+ (NSURL *)googleMapsURLFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    return [NSURL URLWithString:[[NSString stringWithFormat:@"comgooglemaps://?saddr=%@&daddr=%@&directionsmode=%@", from, to, mode] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

+ (Shortcut *)uberShortcutFrom:(NSString *)from to:(NSString *)to
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = [NSString stringWithFormat:@"Uber Home"];
    shortcut.icon = @"uber";
    shortcut.url = [self uberURLForFrom:from to:to];

    return shortcut;
}

+ (NSURL *)uberURLForFrom:(NSString *)from to:(NSString *)to
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"uber://?action=setPickup&pickup[formatted_address]=%@&[formatted_address]=%@", from, to]];
}

+ (Shortcut *)smsShortcutForNumber:(NSString *)number name:(NSString *)name
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = [NSString stringWithFormat:@"Text Message %@", name];
    shortcut.icon = @"imessage";
    shortcut.url = [self smsURLForPhoneNumber:number];

    return shortcut;
}

+ (NSURL *)smsURLForPhoneNumber:(NSString *)number
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", number]];
}

+ (Shortcut *)yelpShortcutForSearch:(NSString *)search
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = [NSString stringWithFormat:@"Search Yelp for %@", search];
    shortcut.icon = @"yelp";
    shortcut.url = [self yelpSearchForName:search];

    return shortcut;
}

+ (NSURL *)yelpSearchForName:(NSString *)name
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"yelp:///search?terms=%@", name]];
}

+ (Shortcut *)yoShortcutForRecipient:(NSString *)recipient
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = [NSString stringWithFormat:@"YO %@", recipient];
    shortcut.recipient = recipient;
    shortcut.icon = @"yo";

    return shortcut;
}

+ (Shortcut *)facebookEventShortcutForEventID:(NSString *)eventID eventName:(NSString *)eventName
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = eventName;
    shortcut.icon = @"fb";
    shortcut.url = [self facebookEventURLForEventID:eventID];

    return shortcut;
}

+ (NSURL *)facebookEventURLForEventID:(NSString *)eventID
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"fb://event?id=%@", eventID]];
}

+ (Shortcut *)rdioShortcutForWebURLString:(NSString *)urlString name:(NSString *)name
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = [NSString stringWithFormat:@"Listen to %@", name];
    shortcut.icon = @"rdio";
    shortcut.url = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@"http" withString:@"rdio"]];

    return shortcut;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.recipient forKey:@"recipient"];
    [encoder encodeObject:self.icon forKey:@"icon"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.message forKey:@"message"];
    [encoder encodeObject:[NSNumber numberWithInt:self.amount] forKey:@"amount"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.url = [decoder decodeObjectForKey:@"url"];
        self.recipient = [decoder decodeObjectForKey:@"recipient"];
        self.icon = [decoder decodeObjectForKey:@"icon"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.message = [decoder decodeObjectForKey:@"message"];
        self.amount = [[decoder decodeObjectForKey:@"amount"] integerValue];
    }
    return self;
}

@end
