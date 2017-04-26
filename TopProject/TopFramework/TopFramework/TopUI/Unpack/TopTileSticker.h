//
//  TopTileSticker.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBaseStyledView.h"
typedef enum{
    TopTileStickerType_small_horizontal,
    TopTileStickerType_big_horizontal,
    TopTileStickerType_small_vertical,
    TopTileStickerType_big_vertical
} TopTileStickerType;

@class TopTileSticker;
@protocol TileDragDelegateProtocol <NSObject>
-(void)tileView:(TopTileSticker*)tileView didDragToPoint:(CGPoint)pt;
-(void)tileView:(TopTileSticker*)tileView dragToPoint:(CGPoint)pt;

@end

@interface TopTileSticker : TopBaseStyledView

@property (strong, nonatomic) id<TileDragDelegateProtocol> dragDelegate;
- (instancetype)initWithNumber:(NSInteger)number
                          type:(TopTileStickerType)type;

- (NSInteger)number;
@end
