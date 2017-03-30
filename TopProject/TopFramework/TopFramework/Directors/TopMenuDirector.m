//
//  TopMenuDirector.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopMenuDirector.h"
#import "TOPPageController.h"
#import "TopPage.h"
#import "TopStickersDirector.h"
#import "TopLayoutFactory.h"



static TopMenuDirector *sharedMenuDirector = nil;

@implementation TopMenuDirector
+ (id)sharedDirector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMenuDirector = [[self alloc] init];
    });
    return sharedMenuDirector;
}

-(NSArray <UIViewController *>*) menuControllers{
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
@end
