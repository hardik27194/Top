//
//  TopPacket.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 01/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopPacket : NSObject
- (instancetype)initWithArray:(NSArray <NSNumber *>*)stickers;
- (NSArray *)stickers;

@end
