//
//  TopMenuDirector.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "TOPPageController.h"

@interface TopControllersDirector : NSObject
+ (TopControllersDirector *)sharedDirector;

// Unpack controller
- (void)showUnPackControllerWithEndingBlock:(void(^)(id data))endingBlock;
- (void)dismissUnPackController:(UIView *)unPackControllerView;

// Visualized controller
- (UIViewController *)askVisualizedController;
- (void)changedVisualizedController:(UIViewController *)controller;

// Main controllers
- (NSArray <TopPageController  *>*)pageControllersSplitInCategories;


@end
