//
//  TopMenuDirector.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopControllersDirector.h"

#import "TopAppDelegate.h"
#import "TopUnpackControllerView.h"
#import "TopPage.h"
#import "TopStickersDirector.h"
#import "TopLayoutFactory.h"

#import "TopScrollerBaseLayout.h"

static TopControllersDirector *sharedControllersDirector = nil;

@interface TopControllersDirector (){
    NSMutableArray *_menuControllers;
    UIViewController *_visualizedController;
}
@end

@implementation TopControllersDirector
+ (TopControllersDirector* )sharedDirector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedControllersDirector = [[self alloc] init];
    });
    return sharedControllersDirector;
}
- (NSArray <TopScrollerController *>*)scrollControllersSplitInCategories{
    
    if (_menuControllers != nil) {
        return _menuControllers;
    }
    _menuControllers = [[NSMutableArray alloc]init];

    NSArray <TopCategory *> *categories = [[TopStickersDirector sharedDirector] askTopCategories];

    TopBackendLessConfiguration *topConfiguration = [TopAppDelegate topAppDelegate].backendlessConfiguration;
    BOOL menuCategories = topConfiguration.configuration.menuCategories;
    
    
    NSMutableArray *pages = [[NSMutableArray alloc]init];

    for (TopCategory *category in categories ) {
        NSArray <TopPage *> *dataArray =  [[TopStickersDirector sharedDirector] askTopPagesForCategory:category];
        TopScrollerBaseLayout *basePage = [[TopScrollerBaseLayout alloc]initFromPages:dataArray];
        [pages addObject:basePage];
        /**
         ------ ATTENTION !! ----
         A topPage is not page layout:
         for this reason a TopScrollerBaseLayout could load multiple toppages
         */
    }
    
    TopScrollerController *scrollerController = [[TopScrollerController alloc]initWithScrollerLayouts:pages];
    [_menuControllers addObject:scrollerController];

    return _menuControllers;
    
}
- (NSArray <TopPageController  *>*)pageControllersSplitInCategories{
    
    if (_menuControllers != nil) {
        return _menuControllers;
    }
    _menuControllers = [[NSMutableArray alloc]init];

    NSArray <TopCategory *> *categories = [[TopStickersDirector sharedDirector] askTopCategories];
    
    TopBackendLessConfiguration *topConfiguration = [TopAppDelegate topAppDelegate].backendlessConfiguration;
    BOOL menuCategories = topConfiguration.configuration.menuCategories;
    
    
    NSMutableArray *allPages = [[NSMutableArray alloc]init];
    
    for (TopCategory *category in categories) {
        NSArray <TopPage *> *dataArray =  [[TopStickersDirector sharedDirector] askTopPagesForCategory:category];
        NSMutableArray *pages = [[NSMutableArray alloc]init];
        for (TopPage *page in dataArray) {
            BasePageViewController *controller = [TopLayoutFactory layoutFromTopPage:page];
            if (controller) {
                [pages addObject:controller];
            }
        }
        [allPages addObjectsFromArray:pages];
        if (menuCategories) {
            TopPageController *topPageController = [[TopPageController alloc]initWithPages:pages];
            [_menuControllers addObject:topPageController];
        }
    }
    if (menuCategories == NO) {
        TopPageController *topPageController = [[TopPageController alloc]initWithPages:allPages];
        [_menuControllers addObject:topPageController];
    }
    return _menuControllers;
}

#pragma mark - unpack controller -
- (void)showUnPackControllerWithEndingBlock:(void(^)(id data))endingBlock{
    UIViewController *mainController = [TopAppDelegate topAppDelegate].viewController;
    TopUnpackControllerView *unPackControllerView = [TopUnpackControllerView unPackView];
    unPackControllerView.frame = mainController.view.bounds;
    unPackControllerView.endingBlock = endingBlock;
    [mainController.view addSubview:unPackControllerView];
    unPackControllerView.transform = CGAffineTransformMakeTranslation(0, unPackControllerView.bounds.size.height);
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        unPackControllerView.transform = CGAffineTransformIdentity;

    } completion:^(BOOL finished) {
    }];
}
- (void)dismissUnPackController:(UIView *)unPackControllerView{
    TopUnpackControllerView *unPackView = (TopUnpackControllerView*)unPackControllerView;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        unPackView.transform = CGAffineTransformMakeTranslation(0, unPackView.bounds.size.height);
        
    } completion:^(BOOL finished) {
        unPackView.endingBlock(nil);
        [unPackView removeFromSuperview];
    }];
}

#pragma mark - menu visualized controller -
-(UIViewController *)askVisualizedController{
    return _visualizedController;
}
#pragma mark - observers methods -
-(void)changedVisualizedController:(UIViewController *)controller{
    _visualizedController = controller;
}
@end
