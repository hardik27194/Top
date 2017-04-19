//
//  StickerViewFactory.h
//  TopFramework
//
//  Created by Makeitapp USA on 03/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StickerView.h"

@interface StickerViewFactory : NSObject
+(StickerView *)stickerViewFromIdentifier:(NSString *)identifier;

@end
