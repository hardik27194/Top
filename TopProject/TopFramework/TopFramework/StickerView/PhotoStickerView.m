//
//  PhotoStickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "PhotoStickerView.h"
@interface PhotoStickerView (){
    CGRect _layerRect;
}
@end
@implementation PhotoStickerView
- (instancetype)initWithNumber:(NSNumber *)number andLayerRect:(CGRect)layerRect
{
    self = [super init];
    if (self) {
        _number = [number integerValue];
        _layerRect = layerRect;
        self.founded = NO;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    if(self.founded){
        [self showStickerPhoto];
    }else{
        [self showPlaceholder];
    }
}
-(void)showStickerPhoto{
    if (self.image = nil) {
        return;
    }
    self.layer.contents = self.image;
    self.layer.contentsRect = _layerRect;
    self.layer.contentsGravity = kCAGravityResizeAspect;
}
-(void)showPlaceholder{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
