//
//  Chance.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 01/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "Chance.h"

static NSMutableArray *raritySource;
@implementation Chance
+(void)load{
     raritySource = [[NSMutableArray alloc]init];
     NSDictionary *rarityCount = @{@(TopRarityLevel_VeryCommon):@(454),
                                 @(TopRarityLevel_Common):@(320),
                                 @(TopRarityLevel_Uncommon):@(170),
                                 @(TopRarityLevel_Rare):@(40),
                                 @(TopRarityLevel_UltraRare):@(15),
                                 @(TopRatityLevel_Impossible):@(1)};
    for (id key in rarityCount) {
        int count = [rarityCount[key] integerValue];
        for (int i = 0; i < count; i++) {
            [raritySource addObject:key];
        }
    }

}
+(TopRarityLevel)randomRarity{
    NSInteger randomNumber = arc4random() % raritySource.count;
    return (TopRarityLevel)[raritySource[randomNumber] integerValue];
}
@end
