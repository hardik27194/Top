//
//  NewViewController.h
//  TopAnimals
//
//  Created by Jacopo Pappalettera on 26/06/14.
//  Copyright (c) 2014 Jacopo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopPageController : UIViewController
- (id)initWithPages:(NSArray *)pages;
- (UIViewController *)currentController;
@end
