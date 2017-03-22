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
#import "TOPPageController.h"
#import "TopLayoutFactory.h"

@implementation TopAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSArray *dataArray =  [TopBackendLessData getAllTopPages];
    NSMutableArray *pages = [[NSMutableArray alloc]init];
    
    
    for (TopPage *page in dataArray) {
        BasePageViewController *controller = [TopLayoutFactory layoutFromTopPage:page];
        if (controller) {
            [pages addObject:controller];
        }
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.viewController = [[TOPPageController alloc]initWithPages:pages];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
