//
//  NewViewController.h
//  TopAnimals
//
//  Created by Jacopo Pappalettera on 26/06/14.
//  Copyright (c) 2014 Jacopo. All rights reserved.
//


#import "_TopStickerControllerProtocol.h"

@interface TopPageController : UIViewController <TopStickerControllerProtocol>
- (instancetype)initWithPages:(NSArray *)pages;
@end
