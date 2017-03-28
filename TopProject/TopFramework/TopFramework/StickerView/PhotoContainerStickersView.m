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
@property (nonatomic,strong) NSMutableArray *stickerFrames;
@property (nonatomic,strong) NSMutableArray *stickerLayerRects;

@property (nonatomic,strong) UIImage *photo;

@end
@implementation PhotoContainerStickersView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stickerLayerRects = [[NSMutableArray alloc]init];
        self.stickerPhotos = [[NSMutableArray alloc]init];
        self.stickerFrames = [[NSMutableArray alloc]init];
        
        stickerContainerGrid defaultGrid;
        defaultGrid.columns = 1;
        defaultGrid.rows = 1;
        self.grid = defaultGrid;
    }
    return self;
}

-(void)buildStickersFromNumbers:(NSArray *)numbers
                    andDelegate:(id<PhotoStickerViewProtocol>)delegate{
    for (NSNumber *number in numbers) {
        PhotoStickerView *stickerNumberView = [[PhotoStickerView alloc]initWithNumber:number];
        stickerNumberView.delegate = delegate;
        stickerNumberView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.stickerPhotos addObject:stickerNumberView];
        [self addSubview:stickerNumberView];
        
    }
}

-(void)computeFrames{
    if (self.stickerLayerRects.count != 0 && self.stickerFrames.count != 0) {
        return;
    }
    NSInteger stickers_count = self.stickerPhotos.count;
    CGFloat frame_portion_width = self.frame.size.width/self.grid.columns;
    CGFloat frame_portion_height = self.frame.size.height/self.grid.rows;
    CGFloat portion_width = 1.0f / self.grid.columns;
    CGFloat portion_height = 1.0f / self.grid.rows;
    NSInteger indexSticker = 0;
    for (int row = 0; row < self.grid.rows; row ++) {
        for (int column = 0; column < self.grid.columns; column ++) {
            CGFloat originX = column * portion_width;
            CGFloat originY = row * portion_height;
            
            CGFloat f_originX = column *frame_portion_width;
            CGFloat f_originY = row *frame_portion_height;
            
            CGRect layerRect = CGRectMake(originX, originY, portion_width, portion_height);
            CGRect frameRect = CGRectMake(f_originX, f_originY, frame_portion_width, frame_portion_height);
            [self.stickerFrames addObject:NSStringFromCGRect(frameRect)];
            [self.stickerLayerRects addObject:NSStringFromCGRect(layerRect)];
        }
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self computeFrames];
    
    NSInteger index = 0;
    for (PhotoStickerView *view in self.stickerPhotos) {
        view.layerRect = CGRectFromString(self.stickerLayerRects[index]);
        view.frame = CGRectFromString(self.stickerFrames[index]);

        index++;
    }
}
@end
