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
#import "StickerViewFactory.h"

@interface BasePageViewController ()<StickerViewProtocol>{
    NSMutableArray *_stickerViews;
}
@property (nonatomic,strong) TopPage *tPage;

@end

@implementation BasePageViewController
@synthesize pl_0;
@synthesize pl_1;
@synthesize pl_2;
@synthesize pl_3;
@synthesize pl_4;
@synthesize pl_5;
@synthesize pl_6;

- (instancetype)initWithTopPage:(TopPage *)topPage
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {
        _tPage = topPage;
        _stickerViews = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    NSDictionary *pageStructure = [[TopStickersDirector sharedDirector] askStickersFromTopPage:self.tPage];
    TopBackendLessConfiguration *topConfiguration = [TopAppDelegate topAppDelegate].backendlessConfiguration;
    [self enumTopObject:^(TopObject *tObject,NSInteger index) {
        NSArray *stickers = pageStructure[@"stickers"][tObject.objectId];
        
        UIView *sview = [self valueForKey:[NSString stringWithFormat:@"pl_%i",(int)index]];
        sview.backgroundColor = [UIColor clearColor];
        StickerView *stickerView = [StickerViewFactory stickerViewFromIdentifier:topConfiguration.topStickerId];
        [_stickerViews addObject:stickerView];
        if (stickerView != nil) {
            stickerView.frame = sview.bounds;
            [sview addSubview:stickerView];
            stickerView.delegate = self;
            [stickerView updateFromTopObject:tObject withNumbers:stickers];
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
//    [self refresh];
}
-(void)viewDidAppear:(BOOL)animated{
    [self refresh];
}
-(void)refresh{
    [self enumTopObject:^(TopObject *tObject,NSInteger index) {
        UIView *sview = [self valueForKey:[NSString stringWithFormat:@"pl_%i",(int)index]];
        StickerView * stickerView = sview.subviews[0];
        [stickerView sizeToFit];

        [stickerView layoutSubviews];
    }];
}
-(void)stickerView:(StickerView *)stickerView askFoundStickers:(void (^)(NSArray *))foundStickers{
    foundStickers([[TopAppDelegate topAppDelegate].topUser stickers]);
}

-(void)enumTopObject:(void(^)(TopObject *tObject,NSInteger index))tObjectBlock{
    NSInteger i = 0;
    for (TopObject *obj in self.tPage.topObjects) {
        tObjectBlock(obj,i);
        i++;
    }
}
-(NSArray *)photoStickerViews{
    NSMutableArray *photoStickerViews = [[NSMutableArray alloc]init];
    for (StickerView *sView in _stickerViews) {
        [photoStickerViews addObjectsFromArray:[sView photoStickerViews]];
    }
    return photoStickerViews;
}

@end
