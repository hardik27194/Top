//
//  PhotoStickerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoStickerView.h"
typedef struct {
    NSInteger rows;
    NSInteger columns;
} stickerContainerGrid;

@interface PhotoContainerStickersView : UIView
@property (nonatomic,assign) stickerContainerGrid grid;
-(NSArray *)photoStickerViews;
-(void)buildStickersFromNumbers:(NSArray *)numbers
                    andDelegate:(id<PhotoStickerViewProtocol>)delegate;

@end
