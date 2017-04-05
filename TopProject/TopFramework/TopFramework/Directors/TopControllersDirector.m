//
//  TopMenuDirector.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopControllersDirector.h"

#import "TopAppDelegate.h"
#import "TOPPageController.h"
#import "TOPUnpackController.h"
#import "TopPage.h"
#import "TopStickersDirector.h"
#import "TopLayoutFactory.h"



static TopControllersDirector *sharedMenuDirector = nil;

@implementation TopControllersDirector
+ (id)sharedDirector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMenuDirector = [[self alloc] init];
    });
    return sharedMenuDirector;
}

- (NSArray <UIViewController *>*) menuControllers{
    NSMutableArray *arrayControllers = [[NSMutableArray alloc]init];
    
    NSArray <TopPage *> *dataArray =  [[TopStickersDirector sharedDirector] askTopPages];
    NSMutableArray *pages = [[NSMutableArray alloc]init];
    
    
    for (TopPage *page in dataArray) {
        BasePageViewController *controller = [TopLayoutFactory layoutFromTopPage:page];
        if (controller) {
            [pages addObject:controller];
        }
    }
    TOPPageController *topPageController = [[TOPPageController alloc]initWithPages:pages];
    
    
    [arrayControllers addObject:topPageController];
    
    return arrayControllers;
}
- (void)showUnPackController{
    UIViewController *mainController = [TopAppDelegate topAppDelegate].viewController;
    TopUnpackController *unpackController = [[TopUnpackController alloc] init];
    
    [mainController presentViewController:unpackController
                                 animated:YES
                               completion:^{
        
    }];
}
@end
