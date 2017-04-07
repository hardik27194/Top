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
    
    UIButton *buttonRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRegister.backgroundColor = [UIColor whiteColor];
    [buttonRegister setTitle:@"register" forState:UIControlStateNormal];
    [buttonRegister setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    buttonRegister.frame = CGRectMake(10, 200, 100, 50);
    buttonRegister.layer.cornerRadius = 10;
    buttonRegister.layer.borderColor = [UIColor blackColor].CGColor;
    buttonRegister.layer.borderWidth = 2;
    [buttonRegister addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRegister];
    
    UIButton *buttonLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLogin.backgroundColor = [UIColor whiteColor];
    [buttonLogin setTitle:@"login" forState:UIControlStateNormal];
    [buttonLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    buttonLogin.frame = CGRectMake(10, 260, 100, 50);
    buttonLogin.layer.cornerRadius = 10;
    buttonLogin.layer.borderColor = [UIColor blackColor].CGColor;
    buttonLogin.layer.borderWidth = 2;
    [buttonLogin addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLogin];
    
    UIButton *buttonLogout = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLogout.backgroundColor = [UIColor whiteColor];
    [buttonLogout setTitle:@"logout" forState:UIControlStateNormal];
    [buttonLogout setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    buttonLogout.frame = CGRectMake(10, 320, 100, 50);
    buttonLogout.layer.cornerRadius = 10;
    buttonLogout.layer.borderColor = [UIColor blackColor].CGColor;
    buttonLogout.layer.borderWidth = 2;
    [buttonLogout addTarget:self action:@selector(logoutUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLogout];
    
    
    UIButton *addSticker = [UIButton buttonWithType:UIButtonTypeCustom];
    addSticker.backgroundColor = [UIColor whiteColor];
    [addSticker setTitle:@"add Sticker" forState:UIControlStateNormal];
    [addSticker setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    addSticker.frame = CGRectMake(10, 380, 150, 50);
    addSticker.layer.cornerRadius = 10;
    addSticker.layer.borderColor = [UIColor blackColor].CGColor;
    addSticker.layer.borderWidth = 2;
    [addSticker addTarget:self action:@selector(addSticker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addSticker];
    
    UIButton *removeSticker = [UIButton buttonWithType:UIButtonTypeCustom];
    removeSticker.backgroundColor = [UIColor whiteColor];
    [removeSticker setTitle:@"remove Sticker" forState:UIControlStateNormal];
    [removeSticker setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    removeSticker.frame = CGRectMake(10, 440, 150, 50);
    removeSticker.layer.cornerRadius = 10;
    removeSticker.layer.borderColor = [UIColor blackColor].CGColor;
    removeSticker.layer.borderWidth = 2;
    [removeSticker addTarget:self action:@selector(removeSticker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeSticker];
    
    UIButton *unpack = [UIButton buttonWithType:UIButtonTypeCustom];
    unpack.backgroundColor = [UIColor whiteColor];
    [unpack setTitle:@"UnPack" forState:UIControlStateNormal];
    [unpack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    unpack.frame = CGRectMake(10, 500, 150, 50);
    unpack.layer.cornerRadius = 10;
    unpack.layer.borderColor = [UIColor blackColor].CGColor;
    unpack.layer.borderWidth = 2;
    [unpack addTarget:self action:@selector(unPack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unpack];
    // Do any additional setup after loading the view.
}

-(void)removeSticker{

    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    [TopBackendLessUserData removeStickers:@[@2]
                                  fromUser:user
                                completion:^(BOOL success, NSError *error) {
                                    if (success) {
                                        NSLog(@"added a sticker");
                                    }
                                    
                                    if (error) {
                                        NSLog(@"error : %@",error.domain);
                                    }
                                }];

}

-(void)addSticker{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    [TopBackendLessUserData addStickers:@[@2,@2,@1]
                                toUser:user
                            completion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"added a sticker");
        }
        
        if (error) {
            NSLog(@"error : %@",error.domain);
        }
    }];
}
-(void)loginUser{
    [TopBackendLessUserData loginUserWithEmail:@"pippoFranco@libero.it"
                                           pwd:@"qwerty"
                                    completion:^(id user, NSError *error) {
        
        [TopAppDelegate topAppDelegate].topUser = [TopUser initializeFromBackendLessUser:user];
        
                                        if ([TopAppDelegate topAppDelegate].topUser != nil) {
                                            NSLog(@"login success !!");
                                            
//                                            [TopBackendLessUserData addStickers:@[@1,@2,@3,@4,@7] toUser:[TopAppDelegate topAppDelegate].topUser completion:^(BOOL success, NSError *error) {
//                                                
//                                            }];
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
