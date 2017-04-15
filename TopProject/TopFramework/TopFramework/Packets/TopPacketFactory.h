//
//  TopPacketFactory.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 12/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopPacket.h"
typedef enum{
    TopPacketType_None,
    TopPacketType_Simple,
    TopPacketType_Uncommon,
    TopPacketType_Rare,
    TopPacketType_UltraRare,
    TopPacketType_Legendary,
    TopPacketType_Random,
    TopPacketType_AllCommon
} TopPacketType;

@import Foundation;

@interface TopPacketFactory : NSObject
+ (Class)packetClassFromType:(TopPacketType)type;
@end
