//
//  TopScrollerController.h
//  TopFramework
//
//  Created by Makeitapp USA on 19/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "_TopStickerControllerProtocol.h"
@interface TopScrollerController : UIViewController<TopStickerControllerProtocol>
- (instancetype)initWithScrollerLayouts:(NSArray *)scrollerLayoutControlles;
@end
