//
//  AppDelegate.m
//  TopAnimals
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "AppDelegate.h"
#define kAppId @"AE9C432A-B676-3C1A-FF5E-DE20C1F98600"
#define kSecretKey @"17FE72FF-30B0-AC01-FFF5-DEAF9C87F100"
#define kVersion @"v1"

@interface AppDelegate ()
@property (nonatomic,strong) TopAppDelegate *topDelegate;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [TopBackendLessConfiguration initBackendlessWithAppId:kAppId
                                                   secret:kSecretKey
                                                  version:kVersion];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
