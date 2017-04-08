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
#import "TopUnpackControllerView.h"
#import "TopPage.h"
#import "TopStickersDirector.h"
#import "TopLayoutFactory.h"

static TopControllersDirector *sharedControllersDirector = nil;

@interface TopControllersDirector (){
    NSMutableArray *_menuControllers;

}
@end

@implementation TopControllersDirector
+ (id)sharedDirector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedControllersDirector = [[self alloc] init];
    });
    return sharedControllersDirector;
}

- (NSArray <UIViewController *>*) menuControllers{
    
    if (_menuControllers != nil) {
        return _menuControllers;
    }
    _menuControllers = [[NSMutableArray alloc]init];

    
    NSArray <TopPage *> *dataArray =  [[TopStickersDirector sharedDirector] askTopPages];
    NSMutableArray *pages = [[NSMutableArray alloc]init];
    
    
    for (TopPage *page in dataArray) {
        BasePageViewController *controller = [TopLayoutFactory layoutFromTopPage:page];
        if (controller) {
            [pages addObject:controller];
        }
    }
    TopPageController *topPageController = [[TopPageController alloc]initWithPages:pages];
    
    
    [_menuControllers addObject:topPageController];
    
    return _menuControllers;
}
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
@end
