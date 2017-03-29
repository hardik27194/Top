//
//  PhotoStickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "PhotoContainerStickersView.h"
#import "AFNetworking.h"
#import "TopStickersDirector.h"


@interface PhotoContainerStickersView()

@property (nonatomic,strong) NSMutableArray *stickerPhotos;

@property (nonatomic,strong) UIImage *photo;

@end
@implementation PhotoContainerStickersView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stickerPhotos = [[NSMutableArray alloc]init];

        
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

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self autoresizesSubviews];
    NSInteger index = 0;
    NSInteger stickers_count = self.stickerPhotos.count;
    CGFloat frame_portion_width = self.bounds.size.width/self.grid.columns;
    CGFloat frame_portion_height = self.bounds.size.height/self.grid.rows;
    CGFloat portion_width = 1.0f / self.grid.columns;
    CGFloat portion_height = 1.0f / self.grid.rows;
    for (int row = 0; row < self.grid.rows; row ++) {
        for (int column = 0; column < self.grid.columns; column ++) {
            CGFloat originX = column * portion_width;
            CGFloat originY = row * portion_height;
            
            CGFloat f_originX = column *frame_portion_width;
            CGFloat f_originY = row *frame_portion_height;
            
            CGRect layerRect = CGRectMake(originX, originY, portion_width, portion_height);
            CGRect frameRect = CGRectMake(f_originX, f_originY, frame_portion_width, frame_portion_height);
            PhotoStickerView *view = self.stickerPhotos[index];
            view.layerRect = layerRect;
            [[TopStickersDirector sharedDirector] saveStickerNumber:view.number
                                                      withLayerRect:layerRect];
            view.frame = frameRect;
            [view layoutSubviews];
            index++;
            
        }
    }
    
    
}
@end
