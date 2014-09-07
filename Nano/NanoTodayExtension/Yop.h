//
//  Yop.h
//  Nano
//
//  Created by Joshua Lauer on 9/7/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#ifndef Nano_Yop_h
#define Nano_Yop_h

@interface YO : NSObject

+ (void) startWithAPIKey: (NSString *) APIKey;

+ (void) sendYO;
+ (void) sendYOToIndividualUser: (NSString *) username;
+ (void) countTotalSubscribers;

@end


#endif
