//
//  PhotoStickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "PhotoContainerStickersView.h"
#import "AFNetworking.h"
#import "mathematics.h"


@interface PhotoContainerStickersView()

@property (nonatomic,strong) NSMutableArray *stickerPhotos;
@property (nonatomic,strong) UIImage *photo;

@end
@implementation PhotoContainerStickersView
-(NSMutableArray *)stickerPhotos{
    if (_stickerPhotos == nil) {
        _stickerPhotos = [[NSMutableArray alloc]init];
    }
    return _stickerPhotos;
}
-(void)buildPhotoWithUrl:(NSURL *)urlPhoto
                    rows:(NSInteger)rows
                 columns:(NSInteger)columns
  stickerViewFromNumbers:(NSArray *)numbers
                 stickerDelegate:(id<PhotoStickerViewProtocol>)delagate{
    NSInteger stickers_count = numbers.count;
    CGFloat portion_width = 1.0f / columns;
    CGFloat portion_height = 1.0f / rows;
    
    NSInteger indexSticker = 0;
    for (int row = 0; row < rows; row ++) {
        for (int column = 0; column < columns; column ++) {
            
            NSNumber *s_number = numbers[indexSticker];
            CGFloat originX = column * portion_width;
            CGFloat originY = row * portion_height;
            CGRect layerRect = CGRectMake(originX, originY, portion_width, portion_height);
            PhotoStickerView *stickerNumberView = [[PhotoStickerView alloc]initWithNumber:s_number andLayerRect:layerRect];
            stickerNumberView.delegate = delagate;
            [self.stickerPhotos addObject:stickerNumberView];
            indexSticker ++;
        }
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_t callerQueue = dispatch_get_current_queue();
        dispatch_queue_t downloadQueue = dispatch_queue_create("top.process_images", NULL);

        dispatch_async(downloadQueue, ^{
            NSData * imageData = [NSData dataWithContentsOfURL:urlPhoto];
            dispatch_async(callerQueue, ^{
                self.photo = [UIImage imageWithData:imageData];
            });
        });

    });

}
-(void)setPhoto:(UIImage *)photo{
    _photo = photo;
    for (PhotoStickerView *photoStickerView in self.stickerPhotos) {
        photoStickerView.image = _photo;
        [photoStickerView layoutIfNeeded];
    }
}


-(NSArray *)getStickerPhotos{
    return self.stickerPhotos;
}

@end
