//
//  TopStyle.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 09/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface TopStyleUtils : NSObject
+ (UIColor *)colorFromHexString:(NSString *)hexString withAlpha:(CGFloat)alpha;
@end
