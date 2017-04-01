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

static TopPacketsDirector *sharedMenuDirector = nil;

@implementation TopPacketsDirector

+ (id)sharedDirector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMenuDirector = [[self alloc] init];
    });
    return sharedMenuDirector;
}


-(TopPacket *)createNewPacket{
    NSInteger total  = [[TopStickersDirector sharedDirector] askTotalStickers];
    if (total <= 0 ) {
        return nil;
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
        return nil;
    }
    
    return [[TopPacket alloc]initWithArray:stickers];
}
@end
