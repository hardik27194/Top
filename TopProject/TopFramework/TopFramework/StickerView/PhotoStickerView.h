//
//  PhotoStickerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoStickerView : UIView
- (instancetype)initWithNumber:(NSNumber *)number andLayerRect:(CGRect)layerRect;
@property (nonatomic,weak) UIImage *image;
@property (nonatomic,assign) BOOL founded;
@property (nonatomic,assign) NSInteger number;

@end
