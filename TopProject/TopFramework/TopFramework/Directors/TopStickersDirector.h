//
//  TopStickersDirector.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 25/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasePageViewController.h"

@interface TopStickersDirector : NSObject
+ (id)sharedDirector;

- (NSArray <TopPage *>*)askTopPages;
- (NSDictionary *)askStickersFromTopPage:(TopPage *)page;
@end
