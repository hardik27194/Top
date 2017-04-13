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

- (void)viewDidLoad{
    [super viewDidLoad];
    NSDictionary *pageStructure = [[TopStickersDirector sharedDirector] askStickersFromTopPage:self.tPage];
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
    TopDetailView *detailView = [TopDetailViewFactory detailViewFromIdentifier:topConfiguration.configuration.detailViewId];
    detailView.detailProtocol = self;
    
    [container.view addSubview:detailView];
    CGRect beginFrame = [stickerView convertRect:stickerView.bounds toView:container.view];
    detailView.frame = beginFrame;
    detailView.beginFrame = beginFrame;
    
    detailView.tmpImage = stickerView.photo;
    [detailView updateWithTopObject:[stickerView topObject]];
    
    CGAffineTransform initImageTransform = [self transformFromRect:detailView.imageView.frame toRect:stickerView.photoContainer.frame];
    
    detailView.imageView.transform = initImageTransform;
    detailView.beginStickerPhotoFrame = stickerView.photoContainer.frame;
    detailView.titleLabel.alpha = 0;
    detailView.descriptionLabel.alpha = 0;
    
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        detailView.frame = CGRectInset(container.view.bounds, 20, 20);
        detailView.imageView.transform = CGAffineTransformIdentity;
        detailView.titleLabel.alpha = 1;
        detailView.descriptionLabel.alpha = 1;
        [detailView layoutIfNeeded];

    } completion:^(BOOL finished) {
        [detailView layoutIfNeeded];

    }];

    
}
- (CGAffineTransform) transformFromRect:(CGRect)sourceRect
                                 toRect:(CGRect)finalRect {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, -(CGRectGetMidX(sourceRect)-CGRectGetMidX(finalRect)), -(CGRectGetMidY(sourceRect)-CGRectGetMidY(finalRect)));
    transform = CGAffineTransformScale(transform, finalRect.size.width/sourceRect.size.width, finalRect.size.height/sourceRect.size.height);
    
    return transform;
}
#pragma mark - detail delegates -
-(void)topDetailView:(TopDetailView *)detailView askCloseWithData:(id)data{
    UIViewController *mainController = [TopAppDelegate topAppDelegate].viewController;
    TopSideMenuContainerController *container = (TopSideMenuContainerController *)[(TopSideMenu *)mainController containerController];
    [container removeOverlayWithAnimationCompletion:^{}];

    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        detailView.frame = detailView.beginFrame;
//        detailView.imageView.transform = [self transformFromRect:<#(CGRect)#> toRect:<#(CGRect)#>];
        detailView.titleLabel.alpha = 0;
        detailView.descriptionLabel.alpha = 0;
       [detailView layoutIfNeeded];

    } completion:^(BOOL finished) {
        [detailView removeFromSuperview];
    }];
}

@end
