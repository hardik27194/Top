//
//  TopAppDelegate.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopAppDelegate.h"


#import "TopMenuTmpl1.h"
#import "TopSideMenu.h"

@implementation TopAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TopMenuTmpl1 *menuTmpl1 = [[TopMenuTmpl1 alloc]init];
    
    self.viewController = [[TopSideMenu alloc]initWithMenuController:menuTmpl1];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
