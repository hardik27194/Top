//
//  TopDetailViewFactory.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 12/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopDetailView.h"

@interface TopDetailViewFactory : NSObject
+(TopDetailView *)detailViewFromIdentifier:(NSString *)identifier;

@end
