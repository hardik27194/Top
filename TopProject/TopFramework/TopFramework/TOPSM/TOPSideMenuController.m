//
//  TopSideMenuController.m
//  TopSideMenu
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TOPSideMenuController.h"
#import "TOPSMIMenuInterface.h"
#import "TOPSMContainerController.h"

@interface TOPSideMenuController ()<TOPSMIMenuProtocol,TOPSMIControllerProtocol>{
    UIViewController<TOPSMIMenuInterface> *_menuController;
    TOPSMContainerController * _containerController;
    UIView *_overlay;
}
@end

@implementation TOPSideMenuController

- (instancetype)initWithMenuController:(UIViewController <TOPSMIMenuInterface> *)menuController
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
    
    
    _containerController = [[TOPSMContainerController alloc]init];
    _containerController.delegate = self;
    [self addChildViewController:_containerController];
    _containerController.view.frame = self.view.bounds;
    [self.view addSubview:_containerController.view];
    [_containerController didMoveToParentViewController:self];
    
    [self addToContainerController:[_menuController firstController]];
    
    // Do any additional setup after loading the view.
}

-(void)addToContainerController:(UIViewController *)controller{
    [_containerController setController:controller];
}

#pragma mark - menu delegate -
-(void)TOPSMDidSelectController:(UIViewController <TOPSMIControllerInterface>*)controller{
    UIViewController *lastController = [_containerController contentController];
    if (lastController != nil) {
        if (lastController != controller) {
            [_containerController removeController:lastController];
        }
    }
    
    [self addToContainerController:controller];
    
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

    } completion:^(BOOL finished) {
        [_overlay removeFromSuperview];
        _overlay = nil;
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
