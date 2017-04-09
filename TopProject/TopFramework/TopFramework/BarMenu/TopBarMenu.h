//
//  TopBarMenu.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBarButton.h"
#import "TopPacketsButton.h"
#import "TopDoubleButton.h"
#import "TopTempsButton.h"

@interface TopBarMenu : UIView
-(void)addButton:(TopBarButton *)button;
-(void)removeButton:(TopBarButton *)button;
-(NSArray <TopBarButton *>*)allButtons;
-(void)update;
@end
