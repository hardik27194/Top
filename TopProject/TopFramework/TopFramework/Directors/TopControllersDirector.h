//
//  TopMenuDirector.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface TopControllersDirector : NSObject
+ (id)sharedDirector;

- (void)showUnPackController;
- (NSArray <UIViewController *>*) menuControllers;

@end
