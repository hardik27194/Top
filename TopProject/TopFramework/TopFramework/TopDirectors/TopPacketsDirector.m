//
//  TopPacketsDirector.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 01/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopPacketsDirector.h"
#import "TopStickersDirector.h"
#import "Chance.h"
#import "TopBackendLessUserData.h"
#import "TopAppDelegate.h"


static TopPacketsDirector *sharedPacketDirector = nil;

@implementation TopPacketsDirector

+ (id)sharedDirector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPacketDirector = [[self alloc] init];
    });
    return sharedPacketDirector;
}


-(void)createNewPacket:(void (^)(TopPacket *packet))packetBlock type:(TopPacketType)type{
    NSInteger total  = [[TopStickersDirector sharedDirector] askTotalStickers];
    if (total <= 0 ) {
        packetBlock(nil);
        return;
    }
    
    NSMutableArray *stickers = [[NSMutableArray alloc]init];
    Class packetClass = [TopPacketFactory packetClassFromType:type];
    NSArray *levels = [packetClass types];
    for (int i = 0; i < levels.count; i++){
         TopRarityLevel level = (TopRarityLevel)[levels[i] integerValue];
        [[TopStickersDirector sharedDirector] askStickerNumberFromRarity:level
                                                              completion:^(NSInteger number, NSError *error) {
                                                                  if (!error) {
                                                                      [stickers addObject:@(number)];
                                                                  }else{
                                                                      NSLog(@"error : %@",error.domain);
                                                                  }
                                                              }];
    }
    if (stickers.count != 5) {
        packetBlock(nil);
        return;
    }
    TopPacket *packet = [[packetClass alloc]initWithArray:stickers];
    
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;

    [TopBackendLessUserData removePacketFromUser:user completion:^(BOOL success, NSError *error) {
        if (success) {
            packetBlock(packet);
        }
    }];

}
@end
