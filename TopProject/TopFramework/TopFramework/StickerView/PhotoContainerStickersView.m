//
//  PhotoStickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "PhotoContainerStickersView.h"
#import "PhotoStickerView.h"
#import "AFNetworking.h"
#import "mathematics.h"


@interface PhotoContainerStickersView(){
    NSURL *_urlPhoto;
}

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
-(void)buildPhotoWithUrl:(NSURL *)urlPhoto stickerViewFromNumbers:(NSArray *)numbers{
    _urlPhoto = urlPhoto;
    
    NSInteger stickers_count = numbers.count;
    if (stickers_count %2 == 1) {
        
    }
    float portion = 1/stickers_count;
    
    for (int i = 0; i< numbers.count; i++) {
        NSNumber *s_number = numbers[i];
        NSInteger colum =  portion * i;
        NSInteger row =  i % stickers_count/2;

        PhotoStickerView *stickerNumberView = [[PhotoStickerView alloc]initWithNumber:s_number andLayerRect:CGRectMake(row, colum, portion, portion)];
        [self.stickerPhotos addObject:stickerNumberView];
    }
  
}

-(void)number:(NSNumber *)numberSticker found:(BOOL)founded{
    for (PhotoStickerView *view in self.stickerPhotos) {
        if (view.number == [numberSticker integerValue]) {
            view.founded = founded;
        }
    }
    [self update];
}
-(void)update{
    NSInteger founded = [self foundedCount];
    if (founded == 0) {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIImageView *tmpImageView = [[UIImageView alloc]init];
        [tmpImageView setImageWithURL:[NSURL URLWithString:_urlPhoto] placeholderImage:nil];
        self.photo = tmpImageView.image;
    });

    if (self.photo == nil) {
        return;
    }
    
    
}
-(NSInteger)foundedCount{
    NSInteger founded = 0;
    
    for (PhotoStickerView *view in self.stickerPhotos) {
        if (view.founded == YES) {
            founded ++;
        }
    }
    return founded;
}
-(NSArray *)getStickerPhotos{
    return self.stickerPhotos;
}

-(void)splitImage{
    if (self.photo == nil) {
        return;
    }
    
    for (PhotoStickerView *photoStickerView in self.stickerPhotos) {
        photoStickerView.image = self.photo;
    }
}
@end
