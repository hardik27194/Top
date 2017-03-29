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
-(void)photoStickerView:(PhotoStickerView* )stickerNumberView isFound:(void(^)(BOOL found))foundBlock;

@end
@interface PhotoStickerView : UIView
- (instancetype)initWithNumber:(NSNumber *)number;


@property (nonatomic,assign) id<PhotoStickerViewProtocol> delegate;
@property (nonatomic,assign) NSInteger number;
@property (nonatomic,assign) CGRect layerRect;
@property (nonatomic,assign) BOOL found;

@end
