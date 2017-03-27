//
//  BasePageViewController.m
//  TopAnimals
//
//  Created by Jacopo Pappalettera on 27/06/14.
//  Copyright (c) 2014 Jacopo. All rights reserved.
//

#import "BasePageViewController.h"
#import "TopAppDelegate.h"
#import "TopStickersDirector.h"

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

- (void)viewDidLoad{
    [super viewDidLoad];
    NSDictionary *pageStructure = [[TopStickersDirector sharedDirector] askStickersFromTopPage:self.tPage];
    
    for (int i = 0; i < self.tPage.topObjects.count; i++) {
        TopObject *tObject = self.tPage.topObjects[i];
        NSArray *stickers = pageStructure[@"stickers"][tObject.objectId];
        StickerView *sview = [self valueForKey:[NSString stringWithFormat:@"pl_%i",i]];
        [sview updateFromTopObject:tObject withNumbers:stickers];
    }
 
}
-(void)viewWillAppear:(BOOL)animated
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    [self refresh];
}
-(void)refresh{
    NSArray *stickers = [[TopAppDelegate topAppDelegate].topUser stickers];
    for (int i = 0; i < self.tPage.topObjects.count; i++) {
        StickerView *sview = [self valueForKey:[NSString stringWithFormat:@"pl_%i",i]];
        for (NSNumber *numberSticker in sview.numberStickers) {
            [[TopStickersDirector sharedDirector] askFoundSticker:numberSticker
                                                inFoundedStickers:stickers
                                                       completion:^(BOOL found) {
                [sview updateNumber:numberSticker ifFounded:found];
            }];
        }
        
    }
}


@end
