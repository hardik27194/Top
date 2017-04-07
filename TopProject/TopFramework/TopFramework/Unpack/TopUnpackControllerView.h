//
//  TopUnpackControllerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopUnpackControllerView : UIView
@property (nonatomic, copy) void (^endingBlock)(id data);
@end
