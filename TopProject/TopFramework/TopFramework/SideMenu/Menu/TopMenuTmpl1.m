//
//  TopMenuTmpl1.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopMenuTmpl1.h"


#import "TopBackendLessData.h"
#import "TopBackendLessUserData.h"

#import "BasePageViewController.h"
#import "TopLayoutFactory.h"
#import "TOPPageController.h"
#import "TopUser.h"
#import "TopAppDelegate.h"


@interface TopMenuTmpl1 ()

@end

@implementation TopMenuTmpl1
@synthesize delegate;

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
    
    // Do any additional setup after loading the view.
}
-(void)loginUser{
    [TopBackendLessUserData loginUserWithEmail:@"pippoFranco@libero.it"
                                           pwd:@"qwerty"
                                    completion:^(NSDictionary *data, NSError *error) {
        
        
        TopUser *user = [TopUser initializeAccountWithData:data];
        [TopAppDelegate topAppDelegate].topUser = user;
        
                                        if ([TopAppDelegate topAppDelegate].topUser != nil) {
                                            NSLog(@"login success !!");
                                        }
        
    }];
}
-(void)logoutUser{
    [TopBackendLessUserData logoutUser:^(BOOL success, NSError *error) {
        if (success) {
            [TopAppDelegate topAppDelegate].topUser = nil;
            if ([TopAppDelegate topAppDelegate].topUser == nil) {
                NSLog(@"logout success !!");
            }
        }
    }];
}
-(void)registerUser{
    [TopBackendLessUserData registerUserWithName:@"Pippo"
                                         surname:@"Franco"
                                             pwd:@"qwerty"
                                           email:@"pippoFranco@libero.it"
                                      completion:^(NSDictionary *data, NSError *error) {
                                          if (error == nil) {
                                              
                                          }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIViewController *)firstController{
    //tmp implementation
    NSArray *dataArray =  [TopBackendLessData getAllTopPages];
    NSMutableArray *pages = [[NSMutableArray alloc]init];
    
    
    for (TopPage *page in dataArray) {
        BasePageViewController *controller = [TopLayoutFactory layoutFromTopPage:page];
        if (controller) {
            [pages addObject:controller];
        }
    }

    return [[TOPPageController alloc]initWithPages:pages];
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
