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
        int count = (int)[rarityCount[key] integerValue];
        for (int i = 0; i < count; i++) {
            [raritySource addObject:key];
        }
    }

}
+(TopRarityLevel)randomRarity{
    NSInteger randomNumber = arc4random() % raritySource.count;
    return (TopRarityLevel)[raritySource[randomNumber] integerValue];
}
+(TopRarityLevel)luck:(NSInteger)luckyLevel{

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    switch (luckyLevel) {
        case 0:{
            for (int i = 0; i< 3; i++) {
                [arr addObject:@(TopRarityLevel_Common)];
            }
            [arr addObject:@(TopRarityLevel_Uncommon)];
        }
            break;
        case 1:{
            for (int i = 0; i< 5; i++) {
                [arr addObject:@(TopRarityLevel_Uncommon)];
            }
            [arr addObject:@(TopRarityLevel_Rare)];
        }
            
            break;
        case 2:{
            for (int i = 0; i< 10; i++) {
                [arr addObject:@(TopRarityLevel_Rare)];
            }
            [arr addObject:@(TopRarityLevel_UltraRare)];
        }
        case 3:{
            for (int i = 0; i< 2; i++) {
                [arr addObject:@(TopRarityLevel_Rare)];
            }
            [arr addObject:@(TopRarityLevel_UltraRare)];
        }
        case 4:{
            for (int i = 0; i< 40; i++) {
                [arr addObject:@(TopRarityLevel_UltraRare)];
            }
            [arr addObject:@(TopRatityLevel_Impossible)];
        }
            break;
        
        default:
            break;
    }
    
    NSInteger randomNumber = arc4random() % arr.count;
    return (TopRarityLevel)[arr[randomNumber] integerValue];
}

@end
