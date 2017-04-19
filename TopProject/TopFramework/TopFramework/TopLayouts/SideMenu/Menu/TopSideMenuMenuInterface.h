//
//  TopIMenuController.h
//  TopSideMenu
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TopSideMenuControllerInterface.h"

@protocol TopSideMenuMenuProtocol <NSObject>
-(void)TOPSMDidSelectController:(UIViewController <TopSideMenuControllerInterface>*)controller;
@end

@protocol TopSideMenuMenuInterface <NSObject>
@property (nonatomic,strong) NSArray *menuControllers;
@property (nonatomic,assign) id <TopSideMenuMenuProtocol> delegate;

- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers;
- (UIViewController *)firstController;
@end


