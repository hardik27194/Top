//
//  TopScrollerController.h
//  TopFramework
//
//  Created by Makeitapp USA on 19/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopScrollerBaseLayout.h"

@interface TopScrollerController : UIViewController
- (instancetype)initWithScrollerLayouts:(NSArray <TopScrollerBaseLayout *>*)scrollerLayoutControlles;
- (UIViewController *)currentController;
@end
