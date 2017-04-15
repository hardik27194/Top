//
//  TopStyler.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 15/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopBaseStyledView.h"



@interface TopStyleDirector : NSObject

+ (TopStyleDirector *)sharedDirector;

- (TopStyle *)styleForView:(TopBaseStyledView *)styleView
                     forState:(TopViewStyleState)styleState;

@end
