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
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *icon;

+ (Shortcut *)shortcutForSelectorString:(NSString *)string
                               WithArgs:(NSArray *)args;

+ (Shortcut *)venmoShortcutWithRecipient:(NSString *)recipient
                                  amount:(NSString *)amount
                                 message:(NSString *)message;

+ (Shortcut *)googleMapsShortcutFrom:(NSString *)from
                                  to:(NSString *)to
                                mode:(NSString *)mode;

+ (Shortcut *)uberShortcutFrom:(NSString *)from
                            to:(NSString *)to;

+ (Shortcut *)smsShortcutForNumber:(NSString *)number
                              name:(NSString *)name;

+ (Shortcut *)yelpShortcutForSearch:(NSString *)search;

+ (Shortcut *)yoShortcutForRecipient:(NSString *)recipient;

+ (Shortcut *)facebookEventShortcutForEventID:(NSString *)eventID
                                    eventName:(NSString *)eventName;

+ (Shortcut *)rdioShortcutForArtistName:(NSString *)name;

@end
