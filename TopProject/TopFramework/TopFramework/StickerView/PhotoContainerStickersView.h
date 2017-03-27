//
//  PhotoStickerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoContainerStickersView : UIView
-(void)buildPhotoWithUrl:(NSURL *)urlPhoto stickerViewFromNumbers:(NSArray *)numbers;
-(NSArray *)getStickerPhotos;
-(void)number:(NSNumber *)numberSticker found:(BOOL)founded;

@end
