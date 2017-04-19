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

#import "TopControllersDirector.h"

#import "TopStyleDirector.h"
#import "TopDefaultStyler.h"

@implementation TopAppDelegate
@synthesize backendlessConfiguration;

+(TopAppDelegate *)topAppDelegate{
    return (TopAppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // to do : implement differents navigations for ipad and iphone
    
    NSArray <UIViewController *> *menuControllers = [[TopControllersDirector sharedDirector] pageControllersSplitInCategories];
    TopMenuTmpl1 *menuTmpl1 = [[TopMenuTmpl1 alloc]initWithControllers:menuControllers];
    self.viewController = [[TopSideMenu alloc]initWithMenuController:menuTmpl1];
    
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
