//
//  TopSideMenuController.m
//  TopSideMenu
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TOPSideMenuController.h"
#import "TOPSMIMenuInterface.h"

@interface TOPSideMenuController ()<TOPSMIMenuProtocol,TOPSMIControllerProtocol>{
    UIViewController<TOPSMIMenuInterface> *_menuController;
    UIViewController * _containerController;
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
    
    
    _containerController = [[UIViewController alloc]init];
    [self addChildViewController:_containerController];
    _containerController.view.frame = self.view.bounds;
    [self.view addSubview:_containerController.view];
    [_containerController didMoveToParentViewController:self];
    
    [self addToContainerController:[_menuController firstController]];
    
    // Do any additional setup after loading the view.
}
-(void)removeFromParentController:(UIViewController *)controller{
  
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
}
-(void)addToContainerController:(UIViewController <TOPSMIControllerInterface>*)controller{
    controller.delegate = self;
    [_containerController addChildViewController:controller];
    controller.view.frame = _containerController.view.bounds;
    [_containerController.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - menu delegate -
-(void)TOPSMDidSelectController:(UIViewController <TOPSMIControllerInterface>*)controller{
    UIViewController *lastController = [[_containerController childViewControllers]lastObject];
    if (lastController != nil) {
        if (lastController != controller) {
            [self removeFromParentController:lastController];
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
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _containerController.view.transform = CGAffineTransformMakeTranslation(300, 0);
    } completion:^(BOOL finished) {
        
        
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
