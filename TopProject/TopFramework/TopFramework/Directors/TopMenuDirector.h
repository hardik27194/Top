//
//  TopMenuDirector.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface TopMenuDirector : NSObject
+ (id)sharedDirector;
- (NSArray <UIViewController *>*) menuControllers;

@end
