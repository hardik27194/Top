//
//  TopPacket.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 01/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TopPacket : NSObject
+ (NSArray <NSNumber *>*)types;
- (instancetype)initWithArray:(NSArray <NSNumber *>*)stickers;
- (NSArray *)stickers;

@end

@interface TopSimplePacket : TopPacket

@end

@interface TopUncommonPacket : TopPacket

@end

@interface TopRarePacket : TopPacket

@end

@interface TopUltraRarePacket : TopPacket

@end
@interface TopRandomPacket : TopPacket

@end

@interface TopLegendaryPacket : TopPacket

@end

@interface TopAllCommonPacket : TopPacket

@end
