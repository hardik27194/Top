//
//  Sticker.h
//  Top
//
//  Created by Jacopo Pappalettera on 18/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Sticker : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,assign) NSUInteger number;
@property (nonatomic,strong) NSString *image;
@end
