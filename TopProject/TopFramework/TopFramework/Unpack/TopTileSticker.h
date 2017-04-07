//
//  TopTileSticker.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopTileSticker;
@protocol TileDragDelegateProtocol <NSObject>
-(void)tileView:(TopTileSticker*)tileView didDragToPoint:(CGPoint)pt;
-(void)tileView:(TopTileSticker*)tileView dragToPoint:(CGPoint)pt;

@end

@interface TopTileSticker : UIView

@property (strong, nonatomic) id<TileDragDelegateProtocol> dragDelegate;
- (instancetype)initWithFrame:(CGRect)frame
                    andNumber:(NSInteger)number;
- (NSInteger)number;
@end
