//
//  TopPage.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "TopObject.h"
#import "TopCategory.h"

@interface TopPage : NSObject
@property (nonatomic,assign) NSUInteger index;
@property (nonatomic,assign) NSUInteger assignedIndex;
@property (nonatomic,strong) NSString *iPhoneLayoutName;
@property (nonatomic,strong) NSString *iPadLayoutName;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) TopCategory *topCategory;
@property (nonatomic,strong) NSMutableArray <TopObject *> *topObjects;
@end
