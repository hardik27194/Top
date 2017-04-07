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
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self innerInit];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self innerInit];
    }
    return self;
}
-(void)innerInit{
    self.stickerPhotos = [[NSMutableArray alloc]init];
    stickerContainerGrid defaultGrid;
    defaultGrid.columns = 1;
    defaultGrid.rows = 1;
    self.grid = defaultGrid;
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
-(NSArray *)photoStickerViews{
    return self.stickerPhotos;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self autoresizesSubviews];
    NSInteger index = 0;
    CGFloat frame_portion_width = self.bounds.size.width/self.grid.columns;
    CGFloat frame_portion_height = self.bounds.size.height/self.grid.rows;

    for (int row = 0; row < self.grid.rows; row ++) {
        for (int column = 0; column < self.grid.columns; column ++) {

            CGFloat f_originX = column *frame_portion_width;
            CGFloat f_originY = row *frame_portion_height;
            CGRect frameRect = CGRectMake(f_originX, f_originY, frame_portion_width, frame_portion_height);
            PhotoStickerView *view = self.stickerPhotos[index];
            view.layerRect = [[TopStickersDirector sharedDirector] askLayerRectFromStickerNumber:view.number];

            view.frame = frameRect;
            [view layoutSubviews];
            index++;
        }
    }
}
@end
