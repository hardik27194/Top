//
//  TopIMenuController.h
//  TopSideMenu
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TOPSMIControllerInterface.h"

@protocol TOPSMIMenuProtocol <NSObject>
-(void)TOPSMDidSelectController:(UIViewController <TOPSMIControllerInterface>*)controller;
@end

@protocol TOPSMIMenuInterface <NSObject>
@property (nonatomic,assign) id<TOPSMIMenuProtocol> delegate;
-(UIViewController<TOPSMIControllerInterface> *)firstController;
@end


