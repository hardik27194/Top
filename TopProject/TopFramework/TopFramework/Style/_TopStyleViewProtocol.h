//
//  _TopStyleViewProtocol.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 17/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopStyle.h"

#ifndef _TopStyleViewProtocol_h
#define _TopStyleViewProtocol_h
@protocol TopStyleViewProtocol

@property (nonatomic,assign) TopViewStyleState styleState;
-(void)setStyle:(TopStyle *)style
       forState:(TopViewStyleState)styleState;

-(void)applyStyle:(TopStyle *)style;

@end



#endif /* _TopStyleViewProtocol_h */
