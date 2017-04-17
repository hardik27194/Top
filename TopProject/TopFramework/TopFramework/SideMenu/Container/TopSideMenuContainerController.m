//
//  TOPSMContainerController.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopSideMenuContainerController.h"
#import "BasePageViewController.h"
#import "TopPageController.h"
#import "TopStyleUtils.h"

@interface TopSideMenuContainerController (){
    UIViewController *_contentController;
    UIView *_overlay;
}
@property (nonatomic,weak) IBOutlet UIView *contentControllerView;
@property (nonatomic,strong) TopCategory *category;

@end

@implementation TopSideMenuContainerController
@synthesize delegate;

- (instancetype)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *overlayView = [[UIView alloc]initWithFrame:self.view.bounds];
    overlayView.backgroundColor = [UIColor blackColor];
    overlayView.alpha = 0;
    [self.view addSubview:overlayView];
    _overlay = overlayView;
    
    TopPacketsButton *packetsButton = [[TopPacketsButton alloc]init];
    [self.menu addButton:packetsButton];
    [packetsButton setStyleState:TopViewStyleState_Normal];
    TopDoubleButton *doubleButton = [[TopDoubleButton alloc]init];
    [self.menu addButton:doubleButton];
    [doubleButton setStyleState:TopViewStyleState_Normal];

    TopTempsButton *tempsbutton = [[TopTempsButton alloc]init];
    [self.menu addButton:tempsbutton];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_contentController viewWillAppear:YES];

    [self.menu update];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setController:(UIViewController *)controller{
    _contentController = controller;
    
    [self addChildViewController:controller];
    controller.view.frame = self.contentControllerView.bounds;
    [self.contentControllerView addSubview:controller.view];
    [controller didMoveToParentViewController:self];
    
    TopPageController *pageController = (TopPageController *)controller;
    self.category = [(BasePageViewController *)[pageController currentController] retrieveCategory];
    [self updateStyle];
}

- (void)removeController:(UIViewController *)controller{
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
}

-(UIViewController *)contentController{
    return _contentController;
}
- (IBAction)openAction:(id)sender {
    [self.delegate TOPSMControllerOpenMenu];
}
-(void)updateStyle{
    self.view.backgroundColor = [TopStyleUtils colorFromHexString:self.category.mainColor withAlpha:1];
}
#pragma mark - overlay -
-(void)addOverlayWithAnimationCompletion:(void(^)(void))completion{
    _overlay.frame  = self.view.bounds;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _overlay.alpha = 0.8;
    } completion:^(BOOL finished) {
        completion();
    }];
}
-(void)removeOverlayWithAnimationCompletion:(void (^)(void))completion{
    if (_overlay == nil) {
        completion();
        return;
    }
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _overlay.alpha = 0;
    } completion:^(BOOL finished) {
        completion();
    }];
}
@end
