//
//  ShortcutStore.h
//  Nano
//
//  Created by Nick Lauer on 2014-09-06.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shortcut;

@interface ShortcutStore : NSObject

+ (id)sharedStore;
- (void)addShortcutToStore:(Shortcut *)shortcut;
- (void)removeShortcutFromStore:(Shortcut *)shortcut;
- (void)removeAllShortcuts;
- (NSArray *)getSharedShortcuts;

@end
