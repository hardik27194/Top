//
//  TopPacketsDirector.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 01/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopPacket.h"

@interface TopPacketsDirector : NSObject
+ (id)sharedDirector;
- (TopPacket *)createNewPacket;

@end
