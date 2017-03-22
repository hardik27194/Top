//
//  TOPSMContainerController.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPSMIControllerInterface.h"

@interface TOPSMContainerController : UIViewController <TOPSMIControllerInterface>

- (void)setController:(UIViewController *)controller;
- (void)removeController:(UIViewController *)controller;
- (UIViewController *)contentController;

@end
