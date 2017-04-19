//
//  TopObject.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopObject : NSObject
@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,assign) NSUInteger rarity;
@property (nonatomic,assign) NSUInteger rows;
@property (nonatomic,assign) NSUInteger columns;

@end
