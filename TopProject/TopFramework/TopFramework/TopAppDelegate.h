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
#import "TopBackendLessUserData.h"

@interface TopAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;



@property (strong, nonatomic) TopBackendLessConfiguration *backendlessConfiguration;
@property (strong, nonatomic) TopUser *topUser;
@property (assign, nonatomic) Class stylerClass;


+(TopAppDelegate *)topAppDelegate;

@end
