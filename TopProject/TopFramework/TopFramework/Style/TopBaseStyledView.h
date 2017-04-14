//
//  TopBaseStyledView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 15/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopStyle.h"

typedef enum{
    TopViewStyleState_Normal,
    TopViewStyleState_Highlighted,
    TopViewStyleState_Selected,
    TopViewStyleState_Warning,
    TopViewStyleState_Disabled
} TopViewStyleState;


@interface TopBaseStyledView : UIView
@property (nonatomic,assign) TopViewStyleState styleState;
-(void)setStyle:(TopStyle *)style
       forState:(TopViewStyleState)styleState;
@end
