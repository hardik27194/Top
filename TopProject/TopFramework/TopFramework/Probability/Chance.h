//
//  Chance.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 01/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    TopRarityLevel_VeryCommon,
    TopRarityLevel_Common,
    TopRarityLevel_Uncommon,
    TopRarityLevel_Rare,
    TopRarityLevel_UltraRare,
    TopRatityLevel_Impossible    
} TopRarityLevel;


@interface Chance : NSObject
+(TopRarityLevel)randomRarity;

@end
