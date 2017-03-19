//
//  TopAppDelegate.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopAppDelegate.h"
#import "Backendless.h"
#import "TopBackendLessData.h"

@implementation TopAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"init");
   NSArray *data =  [TopBackendLessData getAllPages];
    
    return YES;
}

@end
