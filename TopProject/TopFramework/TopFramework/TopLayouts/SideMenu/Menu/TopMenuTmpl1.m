//
//  TopMenuTmpl1.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopMenuTmpl1.h"

#import "TopStickersDirector.h"

#import "TopBackendLessUserData.h"

#import "BasePageViewController.h"
#import "TopLayoutFactory.h"
#import "TOPPageController.h"
#import "TopAppDelegate.h"
#import "TopPacketsDirector.h"

@interface controllerButton : UIButton
@property (nonatomic,strong) UIViewController *controller;
@end
@implementation controllerButton



@end

@interface TopMenuTmpl1 ()
@end

@implementation TopMenuTmpl1
@synthesize menuControllers;
@synthesize delegate;

-(instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers{
    self = [super init];
    if (self) {
        self.menuControllers = controllers;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    NSInteger offsetY = 40;
    UIButton *buttonRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRegister.backgroundColor = [UIColor whiteColor];
    [buttonRegister setTitle:@"register" forState:UIControlStateNormal];
    [buttonRegister setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    buttonRegister.frame = CGRectMake(10, offsetY, 100, 50);
    buttonRegister.layer.cornerRadius = 10;
    buttonRegister.layer.borderColor = [UIColor blackColor].CGColor;
    buttonRegister.layer.borderWidth = 2;
    [buttonRegister addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRegister];
    offsetY+=60;
    UIButton *buttonLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLogin.backgroundColor = [UIColor whiteColor];
    [buttonLogin setTitle:@"login" forState:UIControlStateNormal];
    [buttonLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    buttonLogin.frame = CGRectMake(10, offsetY, 100, 50);
    buttonLogin.layer.cornerRadius = 10;
    buttonLogin.layer.borderColor = [UIColor blackColor].CGColor;
    buttonLogin.layer.borderWidth = 2;
    [buttonLogin addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLogin];
    offsetY+=60;

    UIButton *buttonLogout = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLogout.backgroundColor = [UIColor whiteColor];
    [buttonLogout setTitle:@"logout" forState:UIControlStateNormal];
    [buttonLogout setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    buttonLogout.frame = CGRectMake(10, offsetY, 100, 50);
    buttonLogout.layer.cornerRadius = 10;
    buttonLogout.layer.borderColor = [UIColor blackColor].CGColor;
    buttonLogout.layer.borderWidth = 2;
    [buttonLogout addTarget:self action:@selector(logoutUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLogout];
    offsetY+=60;

    for (UIViewController *controller in self.menuControllers) {
        controllerButton *buttonController = [controllerButton buttonWithType:UIButtonTypeCustom];
        buttonController.frame = CGRectMake(10, offsetY, 100, 60);
        [buttonController setTitle:@"controller" forState:UIControlStateNormal];
        [buttonController setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        buttonController.layer.borderColor = [UIColor blackColor].CGColor;
        buttonController.layer.borderWidth = 2;
        buttonController.backgroundColor = [UIColor whiteColor];
        buttonController.controller = controller;
        [buttonController addTarget:self action:@selector(selectControllerFromButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonController];
        offsetY+=70;

    }
    
    // Do any additional setup after loading the view.
}
- (void)selectControllerFromButton:(controllerButton *)button{
    [self.delegate TOPSMDidSelectController:button.controller];
}

-(void)loginUser{
    [TopBackendLessUserData loginUserWithEmail:@"pippoFranco@libero.it"
                                           pwd:@"qwerty"
                                    completion:^(id user, NSError *error) {
        
        [TopAppDelegate topAppDelegate].topUser = [TopUser initializeFromBackendLessUser:user];
        
                                        if ([TopAppDelegate topAppDelegate].topUser != nil) {
                                            NSLog(@"login success !!");
                                                                               }
        
    }];
}
-(void)logoutUser{
    [TopBackendLessUserData logoutUser:^(BOOL success, NSError *error) {
        if (success) {
            [TopAppDelegate topAppDelegate].topUser = nil;
            NSLog(@"logout success !!");
        }
    }];
}
-(void)registerUser{
    [TopBackendLessUserData registerUserWithName:@"Pippo"
                                         surname:@"Franco"
                                             pwd:@"qwerty"
                                           email:@"pippoFranco@libero.it"
                                      completion:^(id user, NSError *error) {
                                          if (error == nil) {
                                              
                                          }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIViewController *)firstController{
    return menuControllers.count > 0 ? menuControllers[0] : nil;
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
