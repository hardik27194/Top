//
//  TopScrollerBaseLayout.h
//  TopFramework
//
//  Created by Makeitapp USA on 19/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePageViewController.h"

@interface TopScrollerBaseLayout : UIViewController
- (instancetype)initFromPages:(NSArray <TopPage *> *)pages;
- (void)build;
- (void)refreshCurrentPage;
- (BasePageViewController *)currentPageController;

@end
