//
//  TopStickSessionDirector.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopTileSticker.h"

@interface TopStickSessionDirector : NSObject
+ (id)sharedDirector;
- (void)startSessionWithOldTileStickers;
- (void)startSessionWithTileStickers:(NSArray<TopTileSticker *> *)tileStickers
                           animation:(void(^)(void))animation;
-(void)autoLoadsDoublesCompletion:(void(^)(void))completion;


@end
