//
//  TopAppDelegate.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

@import UIKit;
@import Foundation;

#import "TopBackendLessConfiguration.h"

@interface TopAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) TopBackendLessConfiguration *backendlessConfiguration;
+(TopAppDelegate *)topAppDelegate;

@end
