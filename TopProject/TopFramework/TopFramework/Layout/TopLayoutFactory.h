//
//  TopLayoutFactory.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasePageViewController.h"

@interface TopLayoutFactory : NSObject
+(BasePageViewController *)layoutFromTopPage:(TopPage *)topPage;
@end
