//
//  PhotoStickerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoStickerView.h"

@class  PhotoContainerStickersView;

@protocol PhotoContainerStickerViewProtocol
-(void)photoContainer:(PhotoContainerStickersView *)photoContainer cointainerIsCompleted:(BOOL)completed;
@end


typedef struct {
    NSInteger rows;
    NSInteger columns;
} stickerContainerGrid;

@interface PhotoContainerStickersView : UIView
@property (nonatomic,assign) stickerContainerGrid grid;
@property (nonatomic,assign) id <PhotoContainerStickerViewProtocol>containerDelegate;

-(NSArray *)photoStickerViews;
-(void)buildStickersFromNumbers:(NSArray *)numbers
                    andDelegate:(id<PhotoStickerViewProtocol>)delegate;

@end
