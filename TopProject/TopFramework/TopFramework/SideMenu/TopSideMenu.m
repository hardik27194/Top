//
//  TopSideMenuController.m
//  TopSideMenu
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopSideMenu.h"
#import "TopSideMenuMenuInterface.h"
#import "TopSideMenuContainerController.h"

@interface TopSideMenu ()<TopSideMenuMenuProtocol,TopSideMenuControllerProtocol>{
    UIViewController<TopSideMenuMenuInterface> *_menuController;
    TopSideMenuContainerController * _containerController;
    UIView *_overlay;
}
@end

@implementation TopSideMenu

- (instancetype)initWithMenuController:(UIViewController <TopSideMenuMenuInterface> *)menuController
{
    self = [super init];
    if (self) {
        _menuController = menuController;
        _menuController.delegate = self;
        _containerController = nil;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:_menuController];
    _menuController.view.frame = CGRectInset(self.view.bounds, 10, 10);
    [self.view addSubview:_menuController.view];
    [_menuController didMoveToParentViewController:self];
    
    
    _containerController = [[TopSideMenuContainerController alloc]init];
    _containerController.delegate = self;
    [self addChildViewController:_containerController];
    _containerController.view.frame = self.view.bounds;
    [self.view addSubview:_containerController.view];
    [_containerController didMoveToParentViewController:self];
    
    [_containerController setController:[_menuController firstController]];
    // Do any additional setup after loading the view.
}


#pragma mark - menu delegate -
-(void)TOPSMDidSelectController:(UIViewController <TopSideMenuControllerInterface>*)controller{
    UIViewController *lastController = [_containerController contentController];
    if (lastController != nil) {
        if (lastController != controller) {
            [_containerController removeController:lastController];
        }
    }
    
    [_containerController setController:controller];
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _containerController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}
#pragma mark - controller delegate -
-(void)TOPSMControllerOpenMenu{
    
    UIView *overlayView = [[UIView alloc]initWithFrame:_containerController.view.bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TOPSMControllerCloseMenu)];
    [overlayView addGestureRecognizer:tap];
    _overlay = overlayView;
    _overlay.alpha = 0;
    _overlay.backgroundColor = [UIColor blackColor];

    [_containerController.view addSubview:_overlay];

    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _containerController.view.transform = CGAffineTransformMakeTranslation(self.view.bounds.size.width-100, 0);
        _overlay.alpha = 0.5;


    } completion:^(BOOL finished) {
        
        
    }];
}
-(void)TOPSMControllerCloseMenu{
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _containerController.view.transform = CGAffineTransformIdentity;
        _overlay.alpha = 0;
        [_containerController viewWillAppear:YES];
    } completion:^(BOOL finished) {
        [_overlay removeFromSuperview];
        _overlay = nil;
    }];
}
@end
