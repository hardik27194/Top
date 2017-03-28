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
-(void)photoStickerView:(PhotoStickerView* )stickerNumberView isFounded:(void(^)(BOOL founded))foundedBlock;

@end
@interface PhotoStickerView : UIView
- (instancetype)initWithNumber:(NSNumber *)number andLayerRect:(CGRect)layerRect;

@property (nonatomic,assign) id<PhotoStickerViewProtocol> delegate;
@property (nonatomic,weak) UIImage *image;
@property (nonatomic,assign) NSInteger number;

@end
