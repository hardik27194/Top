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
#import "TopDetailViewFactory.h"
#import "TopSideMenu.h"
#import "TopSideMenuContainerController.h"

@interface BasePageViewController ()<StickerViewProtocol,TopDetailViewProtocol>{
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

- (TopCategory *)retrieveCategory{
    return _tPage.topCategory;
}

- (instancetype)initWithTopPage:(TopPage *)topPage
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {
        _tPage = topPage;
        _stickerViews = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)photoWithUrl:(NSURL *)photoUrl completion:(void(^)(UIImage* image))photoBlock{
    dispatch_queue_t downloadQueue = dispatch_queue_create("top.process_images", NULL);
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:photoUrl];
        photoBlock([UIImage imageWithData:imageData]);
    });
}

- (void)applyTopPageStyle{
    
    self.view.layer.masksToBounds = YES;
    
    TopBackendLessConfiguration *topConfiguration = [TopAppDelegate topAppDelegate].backendlessConfiguration;
    if (topConfiguration.configuration.useBgImage == NO) {
        return;
    }
    if (self.tPage.bgImage == nil){
        return;
    }
    [self photoWithUrl:[NSURL URLWithString:self.tPage.bgImage]
            completion:^(UIImage *image) {
        self.view.layer.contents = (__bridge id)[image CGImage];
        self.view.layer.contentsGravity = kCAGravityResizeAspectFill;
    }];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    NSDictionary *pageStructure = [[TopStickersDirector sharedDirector] askStickersFromTopPage:self.tPage];
    [self applyTopPageStyle];
    TopBackendLessConfiguration *topConfiguration = [TopAppDelegate topAppDelegate].backendlessConfiguration;
    [self enumTopObject:^(TopObject *tObject,NSInteger index) {
        NSArray *stickers = pageStructure[@"stickers"][tObject.objectId];
        
        UIView *sview = [self valueForKey:[NSString stringWithFormat:@"pl_%i",(int)index]];
        sview.backgroundColor = [UIColor clearColor];
        StickerView *stickerView = [StickerViewFactory stickerViewFromIdentifier:topConfiguration.configuration.stickerViewId];
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
    [self refresh];
}
-(void)viewDidAppear:(BOOL)animated{
//    [self refresh];
}
-(void)refresh{
    [self enumTopObject:^(TopObject *tObject,NSInteger index) {
        UIView *sview = [self valueForKey:[NSString stringWithFormat:@"pl_%i",(int)index]];
        StickerView * stickerView = sview.subviews[0];
        [stickerView sizeToFit];
        [stickerView layoutSubviews];
    }];
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
#pragma mark - delegates -
-(void)stickerView:(StickerView *)stickerView askFoundStickers:(void (^)(NSArray *))foundStickers{
    foundStickers([[TopAppDelegate topAppDelegate].topUser stickers]);
}

-(void)tappedStickerView:(StickerView *)stickerView{
    UIViewController *mainController = [TopAppDelegate topAppDelegate].viewController;
    TopSideMenuContainerController *container = (TopSideMenuContainerController *)[(TopSideMenu *)mainController containerController];
    [container addOverlayWithAnimationCompletion:^{}];

    
    TopBackendLessConfiguration *topConfiguration = [TopAppDelegate topAppDelegate].backendlessConfiguration;
    TopDetailView *detailView = [TopDetailViewFactory detailViewFromIdentifier:topConfiguration.configuration.detailViewId andFrame:CGRectInset(container.view.bounds, 20, 20)];
    detailView.detailProtocol = self;
    detailView.shrinkedView = stickerView;
    
    [container.view addSubview:detailView];
    
    detailView.centerPoint = [stickerView convertPoint:stickerView.center toView:container.view];
    
    [detailView willShrink];
    [detailView shrink];
    [detailView didShrink];
    
    detailView.tmpImage = stickerView.photo;
    [detailView updateWithTopObject:[stickerView topObject]];
    
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [detailView expand];
    } completion:^(BOOL finished) {
    }];
}
#pragma mark - detail delegates -
-(void)topDetailView:(TopDetailView *)detailView askCloseWithData:(id)data{
    UIViewController *mainController = [TopAppDelegate topAppDelegate].viewController;
    TopSideMenuContainerController *container = (TopSideMenuContainerController *)[(TopSideMenu *)mainController containerController];
    [container removeOverlayWithAnimationCompletion:^{}];
    [detailView willShrink];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [detailView shrink];
    } completion:^(BOOL finished) {
        [detailView didShrink];
        [detailView removeFromSuperview];
    }];
}

@end
