//
//  Shortcut.m
//  Nano
//
//  Created by Nick Lauer on 2014-09-06.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "Shortcut.h"

@implementation Shortcut

+ (Shortcut *)shortcutForSelectorString:(NSString *)string
                               WithArgs:(NSArray *)args {
    SEL sel = NSSelectorFromString(string);
    NSMethodSignature *sig = [Shortcut methodSignatureForSelector:sel];
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
    [inv setTarget:[Shortcut class]];
    [inv setSelector:sel];
    for (int i = 0; i < args.count; i++) {
        NSString *arg = args[i];
        [inv setArgument:&arg atIndex:2+i];
    }
    
    Shortcut *shortcut;
    [inv invoke];
    [inv getReturnValue:&shortcut];
    return shortcut;
}

+ (Shortcut *)venmoShortcutWithRecipient:(NSString *)recipient amount:(NSString *)amount message:(NSString *)message
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.recipient = recipient;
    shortcut.amount = [amount integerValue];
    shortcut.message = message;
    shortcut.name = [NSString stringWithFormat:@"Pay %@", recipient];
    shortcut.icon = @"venmo";

    return shortcut;
}

+ (Shortcut *)googleMapsShortcutFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    NSRange firstComma = [to rangeOfString:@","];
    // TODO there is a bug here if theres no comma
    shortcut.name = [NSString stringWithFormat:@"%@ to %@", [mode capitalizedString], [to stringByReplacingCharactersInRange:NSMakeRange(firstComma.location, to.length - firstComma.location) withString:@""]];
    shortcut.icon = @"google";
    shortcut.url = [self googleMapsURLFrom:from to:to mode:mode];
    NSLog(@"%@", shortcut.url);
    return shortcut;
}

+ (NSURL *)googleMapsURLFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    return [NSURL URLWithString:[[NSString stringWithFormat:@"comgooglemaps://?saddr=%@&daddr=%@&directionsmode=%@", from, to, mode] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

+ (Shortcut *)uberShortcutFrom:(NSString *)from to:(NSString *)to
{
    if ([from isEqualToString:@""]) {
        from = @"my_location";
    }
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = [NSString stringWithFormat:@"Uber Home for $10"];
    shortcut.icon = @"uber";
    shortcut.url = [self uberURLForFrom:from to:to];

    return shortcut;
}

+ (NSURL *)uberURLForFrom:(NSString *)from to:(NSString *)to
{
    NSLog(@"%@", [NSString stringWithFormat:@"uber://?action=setPickup&pickup[formatted_address]=%@&[formatted_address]=%@", from, to]);
    return [NSURL URLWithString:[[NSString stringWithFormat:@"uber://?action=setPickup&pickup[formatted_address]=%@&[formatted_address]=%@", from, to] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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

+ (Shortcut *)rdioShortcutForArtistName:(NSString *)name
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = [NSString stringWithFormat:@"Listen to %@", name];
    shortcut.icon = @"rdio";
    shortcut.url = [NSURL URLWithString:[NSString stringWithFormat:@"rdio://www.rdio.com/artist/%@", [name stringByReplacingOccurrencesOfString:@" " withString:@"_"]]];

    return shortcut;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.recipient forKey:@"recipient"];
    [encoder encodeObject:self.icon forKey:@"icon"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.message forKey:@"message"];
    [encoder encodeObject:[NSNumber numberWithUnsignedInteger:self.amount] forKey:@"amount"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.url = [decoder decodeObjectForKey:@"url"];
        self.recipient = [decoder decodeObjectForKey:@"recipient"];
        self.icon = [decoder decodeObjectForKey:@"icon"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.message = [decoder decodeObjectForKey:@"message"];
        self.amount = [[decoder decodeObjectForKey:@"amount"] unsignedIntegerValue];
    }
    return self;
}

@end
