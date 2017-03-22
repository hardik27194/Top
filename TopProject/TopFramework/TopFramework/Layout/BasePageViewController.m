//
//  BasePageViewController.m
//  TopAnimals
//
//  Created by Jacopo Pappalettera on 27/06/14.
//  Copyright (c) 2014 Jacopo. All rights reserved.
//

#import "BasePageViewController.h"

@interface BasePageViewController ()
@property (nonatomic,strong) TopPage *tPage;
@end

@implementation BasePageViewController
- (instancetype)initWithTopPage:(TopPage *)topPage
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {
        _tPage = topPage;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   
    for (int i = 0; i < self.tPage.topObjects.count; i++) {
        TopObject *tObject = self.tPage.topObjects[i];
        StickerView *sview = [self valueForKey:[NSString stringWithFormat:@"pl_%i",i]];
        [sview updateFromTopObject:tObject];
    }
   

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
   
//    for (SingleSticker *sticker in self.stickers) {
//        [sticker checkSticker];
//        [self.view addSubview:sticker];
//        [self updateFrameOfSticker:sticker FromOrientation:orientation];
//    }
}
#pragma mark - Orientation -
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
//    for (SingleSticker *sticker in self.stickers) {
//        [self updateFrameOfSticker:sticker FromOrientation:toInterfaceOrientation];
//    }
}
//- (void)updateFrameOfSticker:(SingleSticker *)sticker FromOrientation:(UIInterfaceOrientation)orientation
//{
//
//    if(UIInterfaceOrientationIsPortrait(orientation))
//    {
//        sticker.frame = sticker.portraitStickerRect;
//    }else
//    {
//        sticker.frame = sticker.landscapeStickerRect;
//        
//    }
//    [sticker setNeedsLayout];
//
//}
#pragma mark - new sticker -

//- (void)insertNewSticker:(SingleSticker *)sticker
//{
////    [self.stickers addObject:sticker];
//}

@end
