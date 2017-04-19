//
//  TopScrollerBaseLayout.m
//  TopFramework
//
//  Created by Makeitapp USA on 19/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopScrollerBaseLayout.h"

@interface TopScrollerBaseLayout ()
@property (nonatomic,weak) UIScrollView *mainScrollView;
@end

@implementation TopScrollerBaseLayout

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mainScrollView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
