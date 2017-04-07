//
//  TopStickersDirector.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 25/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasePageViewController.h"
#import "Chance.h"

@interface TopStickersDirector : NSObject
+ (id)sharedDirector;

- (NSArray <TopPage *>*)askTopPages;
- (NSDictionary *)askStickersFromTopPage:(TopPage *)page;
- (CGRect)askLayerRectFromStickerNumber:(NSInteger)number;
- (NSURL *)askUrlImageFromStickerNumber:(NSInteger)number;
- (NSInteger)askTotalStickers;
- (void)askStickerNumberFromRarity:(TopRarityLevel)topRarityLevel
                        completion:(void(^)(NSInteger number,NSError *error))completion;

@end
