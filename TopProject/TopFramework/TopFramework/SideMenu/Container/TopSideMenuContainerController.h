//
//  TOPSMContainerController.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopSideMenuControllerInterface.h"
#import "TopBarMenu.h"

@interface TopSideMenuContainerController : UIViewController <TopSideMenuControllerInterface>
@property (nonatomic,weak) IBOutlet TopBarMenu *menu;
- (void)setController:(UIViewController *)controller;
- (void)removeController:(UIViewController *)controller;
- (UIViewController *)contentController;


- (void)addOverlayWithAnimationCompletion:(void(^)(void))completion;
- (void)removeOverlayWithAnimationCompletion:(void(^)(void))completion;
@end
