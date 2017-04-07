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


-(void)createNewPacket:(void (^)(TopPacket *packet))packetBlock{
    NSInteger total  = [[TopStickersDirector sharedDirector] askTotalStickers];
    if (total <= 0 ) {
        packetBlock(nil);
    }
    
    NSMutableArray *stickers = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 5; i++){
         TopRarityLevel level = [Chance randomRarity];
        [[TopStickersDirector sharedDirector] askStickerNumberFromRarity:level
                                                              completion:^(NSInteger number, NSError *error) {
                                                                  if (!error) {
                                                                      [stickers addObject:@(number)];
                                                                  }else{
                                                                      // to do : handle error
                                                                  }
                                                              }];
    }
    if (stickers.count != 5) {
        packetBlock(nil);
    }
    TopPacket *packet = [[TopPacket alloc]initWithArray:stickers];
    
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;

    [TopBackendLessUserData removePacketFromUser:user completion:^(BOOL success, NSError *error) {
        if (success) {
            packetBlock(packet);
        }
    }];

}
@end
