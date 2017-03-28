//
//  PhotoStickerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoStickerView.h"

@interface PhotoContainerStickersView : UIView


-(void)buildPhotoWithUrl:(NSURL *)urlPhoto
                    rows:(NSInteger)rows
                 columns:(NSInteger)columns
  stickerViewFromNumbers:(NSArray *)numbers
         stickerDelegate:(id<PhotoStickerViewProtocol>)delagate;

-(NSArray *)getStickerPhotos;

@end
