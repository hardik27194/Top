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

@interface BasePageViewController ()<StickerViewProtocol>
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
    TopBackendLessConfiguration *topConfiguration = [TopAppDelegate topAppDelegate].backendlessConfiguration;
    
    [self enumTopObject:^(TopObject *tObject,NSInteger index) {
        NSArray *stickers = pageStructure[@"stickers"][tObject.objectId];
        
        StickerView *sview = [self valueForKey:[NSString stringWithFormat:@"pl_%i",index]];
        
        sview.delegate = self;
        [sview updateFromTopObject:tObject withNumbers:stickers];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//    [self refresh];
}
-(void)viewDidAppear:(BOOL)animated{
    [self refresh];

}
-(void)refresh{
    [self enumTopObject:^(TopObject *tObject,NSInteger index) {
        StickerView *sview = [self valueForKey:[NSString stringWithFormat:@"pl_%i",index]];
        [sview layoutSubviews];
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


@end
