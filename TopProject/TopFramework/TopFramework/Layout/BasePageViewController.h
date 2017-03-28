//
//  BasePageViewController.h
//  TopAnimals
//
//  Created by Jacopo Pappalettera on 27/06/14.
//  Copyright (c) 2014 Jacopo. All rights reserved.
//

@import UIKit;

#import "TopPage.h"
#import "StickerView.h"

@interface BasePageViewController : UIViewController
@property (nonatomic, weak) IBOutlet StickerView *pl_0;
@property (nonatomic, weak) IBOutlet StickerView *pl_1;
@property (nonatomic, weak) IBOutlet StickerView *pl_2;
@property (nonatomic, weak) IBOutlet StickerView *pl_3;
@property (nonatomic, weak) IBOutlet StickerView *pl_4;
@property (nonatomic, weak) IBOutlet StickerView *pl_5;
@property (nonatomic, weak) IBOutlet StickerView *pl_6;


- (instancetype)initWithTopPage:(TopPage *)topPage;
- (void)refresh;

@end
