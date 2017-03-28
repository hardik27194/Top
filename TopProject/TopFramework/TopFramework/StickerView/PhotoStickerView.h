//
//  PhotoStickerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoStickerView;

@protocol PhotoStickerViewProtocol <NSObject>
-(void)photoStickerView:(PhotoStickerView* )stickerNumberView image:(void(^)(UIImage *image))imageBlock;
-(void)photoStickerView:(PhotoStickerView* )stickerNumberView isFounded:(void(^)(BOOL founded))foundedBlock;

@end
@interface PhotoStickerView : UIView
- (instancetype)initWithNumber:(NSNumber *)number
                         frame:(CGRect)frameRect
                  andLayerRect:(CGRect)layerRect;

@property (nonatomic,assign) id<PhotoStickerViewProtocol> delegate;
@property (nonatomic,assign) NSInteger number;
-(void)setLayerRect:(CGRect)rect;

@end
