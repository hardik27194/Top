//
//  TopPacketFactory.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 12/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopPacketFactory.h"


static NSDictionary *packets;

@implementation TopPacketFactory
+(void)load{
    packets = @{@(TopPacketType_Simple):[TopSimplePacket class],
                @(TopPacketType_Uncommon):[TopUncommonPacket class],
                @(TopPacketType_Rare):[TopRarePacket class],
                @(TopPacketType_UltraRare):[TopUltraRarePacket class],
                @(TopPacketType_Legendary):[TopLegendaryPacket class]};
}

+(Class)packetClassFromType:(TopPacketType)type{

    if (type == TopPacketType_None) {
        type = TopPacketType_Simple;
    }
    
    if (packets[@(type)] == nil) {
        return packets[@(TopPacketType_Simple)];
    }
    
    return packets[@(type)];
}
@end
