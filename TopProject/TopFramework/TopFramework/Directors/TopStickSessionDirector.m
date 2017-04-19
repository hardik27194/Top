//
//  TopStickSessionDirector.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopStickSessionDirector.h"
#import "TopBackendLessUserData.h"
#import "TopAppDelegate.h"
#import "TopControllersDirector.h"
#import "BasePageViewController.h"
#import "TopBarMenu.h"
#import "TopSideMenu.h"
#import "TopSideMenuContainerController.h"

static TopStickSessionDirector *sharedStickSessionDirector = nil;

@interface TopStickSessionDirector ()<TileDragDelegateProtocol>{
    NSMutableArray <TopTileSticker *> * _tileStickers;
}
@end

@implementation TopStickSessionDirector
- (id <TopStickerControllerProtocol>)currentPageController{
    return (id <TopStickerControllerProtocol>)[[TopControllersDirector sharedDirector] askVisualizedController];
}
+ (id)sharedDirector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStickSessionDirector = [[self alloc] init];
    });
    return sharedStickSessionDirector;
}
- (void)startSessionWithOldTileStickers{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    NSMutableArray *tiles = [[NSMutableArray alloc]init];
    for (NSNumber *stickerNumber in [user tmpStickers]) {
        TopTileSticker *sticker = [[TopTileSticker alloc]initWithFrame:CGRectMake(50, 400, 100, 100) andNumber:[stickerNumber integerValue]];
        [tiles addObject:sticker];
    }
    [self startSessionWithTileStickers:tiles animation:nil];
}

- (void)startSessionWithTileStickers:(NSArray<TopTileSticker *> *)tileStickers animation:(void(^)(void))animation{
    if (tileStickers == nil) {
        return;
    }
    NSLog(@"start session");
    if (_tileStickers) {
        [self saveTemporaryTileStickers:_tileStickers];
        for (TopTileSticker *tileSticker in _tileStickers) {
            [tileSticker removeFromSuperview];
        }
        [_tileStickers removeAllObjects];
    }
    _tileStickers = [[NSMutableArray alloc]initWithArray:tileStickers];
    
    UIViewController *mainController = [TopAppDelegate topAppDelegate].viewController;
    for (TopTileSticker *sticker in tileStickers) {
        sticker.dragDelegate = self;
        [mainController.view addSubview:sticker];
    }
    if (animation != nil) {
        animation();
    }
}
-(void)tileView:(TopTileSticker *)tileView didDragToPoint:(CGPoint)pt{
    
    [self checkTileView:tileView withPoint:pt
          inMenuButtons:^(TopBarButton *button,BOOL inrect) {
              
              if (inrect) {
                  [button handleStickerNumber:tileView.number
                                   completion:^(BOOL success){
                                       if (success) {
                                           [self insertSticker:tileView inButton:button completion:^{
                                               [self removeTileView:tileView];
                                               [button relax];
                                               return;
                                           }];
                                       }
                  }];
              }
          }];
    
    
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    
    [self checkTileView:tileView
              withPoint:pt
                 inRect:^(UIView *view) {
                     [self checkNumberTileView:tileView
                                        inView:view
                                       reflect:^(BOOL reflect) {
                                           if (reflect) {
                                               if (![[[TopAppDelegate topAppDelegate].topUser stickers] containsObject:@(tileView.number)]) {
                                                   [TopBackendLessUserData addStickers:@[@(tileView.number)] toUser:user completion:^(BOOL success, NSError *error) {
                                                       if (success) {
                                                           
                                                           [view.superview layoutSubviews];
                                                           [self stickSticker:tileView
                                                                  inPhotoView:view completion:^{
                                                                      [self removeTileView:tileView];
                                                                  }];
                                                           
                                                       }
                                                   }];
                                                   
                                               }
                                               
                                           }
                                       }];
                 } outRect:^(UIView *view) {
                     PhotoStickerView *stickerView = (PhotoStickerView *)view;
                     if (stickerView.found){
                         stickerView.styleState = TopViewStyleState_Selected;
                     }else{
                         stickerView.styleState = TopViewStyleState_Normal;
                     }
                 }];
    
}
-(void)tileView:(TopTileSticker *)tileView dragToPoint:(CGPoint)pt{
    [self checkTileView:tileView withPoint:pt
          inMenuButtons:^(TopBarButton *button,BOOL inrect) {
              if (inrect) {
                  [button highlightWithNumber:tileView.number];
              }else{
                  [button relax];
              }
          }];
    
    [self checkTileView:tileView
              withPoint:pt
                 inRect:^(UIView *view) {
                     [self checkNumberTileView:tileView
                                        inView:view
                                       reflect:^(BOOL reflect) {
                                           PhotoStickerView *photoView = (PhotoStickerView *)view;
                                           
                                           if (reflect) {
                                               photoView.styleState = TopViewStyleState_Highlighted;
                                           }else{
                                               photoView.styleState = TopViewStyleState_Warning;
                                           }
                                       }];
                 } outRect:^(UIView *view) {
                     PhotoStickerView *stickerView = (PhotoStickerView *)view;
                     if (stickerView.found){
                         stickerView.styleState = TopViewStyleState_Selected;
                     }else{
                         stickerView.styleState = TopViewStyleState_Normal;
                     }
                 }];
}
-(void)removeTileView:(TopTileSticker *)topTileSticker{
    if ([_tileStickers containsObject:topTileSticker]) {
        [_tileStickers removeObject:topTileSticker];
    }
    [topTileSticker removeFromSuperview];
    
    if (_tileStickers.count == 0) {
        [self endSession];
    }
}
- (void)endSession{
    NSLog(@"session complete");
}
- (void)forceEndSession{
    
    for (TopTileSticker *sticker in self->_tileStickers) {
        [UIView animateWithDuration:0.5 animations:^{
            sticker.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeTileView:sticker];
        }];
    }
}
-(void)saveTemporaryTileStickers:(NSArray <TopTileSticker*> *)tmpStickers{
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    NSMutableArray *numbers = [[NSMutableArray alloc]init];
    for (TopTileSticker *sticker in tmpStickers) {
        [numbers addObject:@(sticker.number)];
    }
    [TopBackendLessUserData addTmpStickers:numbers toUser:user completion:^(BOOL success, NSError *error) {}];
}
#pragma mark - pragmatical functions -
-(void)autoLoadsDoublesCompletion:(void(^)(void))completion{
    NSArray *copyStickers = [NSArray arrayWithArray:_tileStickers];
    TopUser *user = [TopAppDelegate topAppDelegate].topUser;
    
    NSMutableArray *doubles = [[NSMutableArray alloc]init];
    NSMutableArray *doublesStickers = [[NSMutableArray alloc]init];

    for (TopTileSticker *topSticker in copyStickers) {
        if ([[[TopAppDelegate topAppDelegate].topUser stickers] containsObject:@(topSticker.number)]) {
            [doubles addObject:@(topSticker.number)];
            [doublesStickers addObject:topSticker];
        }
    }
    [TopBackendLessUserData addStickers:doubles toUser:user completion:^(BOOL success, NSError *error) {
        for (TopTileSticker *sticker in doublesStickers) {
            [self removeTileView:sticker];
        }
        completion();
    }];
}


#pragma mark - privates -
-(void)checkTileView:(TopTileSticker *)tileView
           withPoint:(CGPoint)point
       inMenuButtons:(void(^)(TopBarButton *button,bool inrect))menuButtonsBlock{
    UIViewController *mainController = [TopAppDelegate topAppDelegate].viewController;
    TopSideMenu *sideMenu  = (TopSideMenu *)mainController;
    TopSideMenuContainerController *container = (TopSideMenuContainerController *)[sideMenu containerController];
    for (TopBarButton *button in [container.menu allButtons]) {
        CGRect rect  = [button convertRect:button.bounds toView:mainController.view];
        CGPoint convertedPoint = [mainController.view convertPoint:point toView:mainController.view];
        if (CGRectContainsPoint(rect, convertedPoint)) {
            menuButtonsBlock(button,YES);

        }else{
            menuButtonsBlock(button,NO);
        }

    }
}
- (void)checkTileView:(TopTileSticker *)tileView
            withPoint:(CGPoint)point
               inRect:(void(^)(UIView *view))inRectBlock
              outRect:(void(^)(UIView *view))outRectBlock{
    UIViewController *mainController = [TopAppDelegate topAppDelegate].viewController;
    
    for (UIView *view in [(BasePageViewController *)[[self currentPageController] currentController] photoStickerViews]) {
        CGRect rect  = [view convertRect:view.bounds toView:[[self currentPageController] currentController].view];
        CGPoint convertedPoint = [mainController.view convertPoint:point toView:[[self currentPageController] currentController].view];
        if (CGRectContainsPoint(rect, convertedPoint)) {
            inRectBlock(view);
        }else{
            outRectBlock(view);
        }
    }
}
-(void)checkNumberTileView:(TopTileSticker *)tileView
                    inView:(UIView *)view
                   reflect:(void(^)(BOOL reflect))reflectionBlock{
    PhotoStickerView *pView = (PhotoStickerView *)view;
    reflectionBlock(tileView.number == pView.number);
}
-(void)stickSticker:(TopTileSticker *)sticker inPhotoView:(UIView *)view completion:(void(^)(void))completion{
    UIViewController *mainController = [TopAppDelegate topAppDelegate].viewController;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect rect  = [view convertRect:view.bounds toView:mainController.view];
        
        sticker.frame = rect;
    } completion:^(BOOL finished) {
        completion();
    }];
}
-(void)insertSticker:(TopTileSticker *)sticker inButton:(TopBarButton *)button completion:(void(^)(void))completion{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        sticker.transform = CGAffineTransformMakeScale(0.00001, 0.000001);
    } completion:^(BOOL finished) {
        completion();
    }];
}
@end
