//
//  TOPSMContainerController.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopSideMenuContainerController.h"




@interface TopSideMenuContainerController ()
{
    UIViewController *_contentController;
}
@property (nonatomic,weak) IBOutlet UIView *contentControllerView;

@end

@implementation TopSideMenuContainerController
@synthesize delegate;

- (instancetype)init
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    TopPacketsButton *button = [[TopPacketsButton alloc]init];
    [self.menu addButton:button];

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

@end
