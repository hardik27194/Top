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
-(void)buildWithRows:(NSInteger)rows
                 columns:(NSInteger)columns
  stickerViewFromNumbers:(NSArray *)numbers
                 stickerDelegate:(id<PhotoStickerViewProtocol>)delegate{
    NSInteger stickers_count = numbers.count;
    
    CGFloat frame_portion_width = self.frame.size.width/columns;
    CGFloat frame_portion_height = self.frame.size.height/rows;
    CGFloat portion_width = 1.0f / columns;
    CGFloat portion_height = 1.0f / rows;
    
    NSInteger indexSticker = 0;
    for (int row = 0; row < rows; row ++) {
        for (int column = 0; column < columns; column ++) {
            
            NSNumber *s_number = numbers[indexSticker];
            CGFloat originX = column * portion_width;
            CGFloat originY = row * portion_height;
            
            CGFloat f_originX = column *frame_portion_width;
            CGFloat f_originY = row *frame_portion_height;

            CGRect layerRect = CGRectMake(originX, originY, portion_width, portion_height);
            CGRect frameRect = CGRectMake(f_originX, f_originY, frame_portion_width, frame_portion_height);

           PhotoStickerView *stickerNumberView = [[PhotoStickerView alloc]initWithNumber:s_number
                                                                                   frame:frameRect
                                                                            andLayerRect:layerRect];
         
            stickerNumberView.delegate = delegate;
            [self.stickerPhotos addObject:stickerNumberView];
            indexSticker ++;
            
            [self addSubview:stickerNumberView];
            
        }
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    for (PhotoStickerView *photoStickerView in self.stickerPhotos) {
        [photoStickerView layoutSubviews];
    }
}
@end
