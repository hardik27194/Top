//
//  TopSideMenuController.h
//  TopSideMenu
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPSMIMenuInterface.h"

@interface TOPSideMenuController : UIViewController
- (instancetype)initWithMenuController:(UIViewController <TOPSMIMenuInterface> *)menuController;


@end
