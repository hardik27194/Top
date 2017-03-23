//
//  TopSideMenuController.h
//  TopSideMenu
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopSideMenuMenuInterface.h"

@interface TopSideMenu : UIViewController
- (instancetype)initWithMenuController:(UIViewController <TopSideMenuMenuInterface> *)menuController;


@end
