//
//  TopPage.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopObject.h"

@interface TopPage : NSObject
@property (nonatomic,assign) NSUInteger number;
@property (nonatomic,strong) NSString *layoutName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSMutableArray <TopObject *> *topObjects;
@end
