//
//  TopUnpackController.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 05/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopUnpackController.h"

@interface TopUnpackController ()

@end

@implementation TopUnpackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *dismiss = [UIButton buttonWithType:UIButtonTypeCustom];
    dismiss.backgroundColor = [UIColor whiteColor];
    [dismiss setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismiss setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    dismiss.frame = CGRectMake(10, 200, 100, 50);
    dismiss.layer.cornerRadius = 10;
    dismiss.layer.borderColor = [UIColor blackColor].CGColor;
    dismiss.layer.borderWidth = 2;
    [dismiss addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismiss];
    
    // Do any additional setup after loading the view.
}
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
