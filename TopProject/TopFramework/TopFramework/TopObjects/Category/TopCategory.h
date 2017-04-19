//
//  TopCategory.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 09/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopCategory : NSObject
@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *mainColor;
@property (nonatomic,strong) NSString *info;
@property (nonatomic,assign) NSUInteger index;

@end
