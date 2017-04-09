//
//  TopMenuDirector.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface TopControllersDirector : NSObject
+ (TopControllersDirector *)sharedDirector;

- (void)showUnPackControllerWithEndingBlock:(void(^)(id data))endingBlock;
- (void)dismissUnPackController:(UIView *)unPackControllerView;
- (UIViewController *)askVisualizedController;

- (NSArray <UIViewController *>*)menuControllersSplitInCategories;
- (void)changedVisualizedController:(UIViewController *)controller;

@end
