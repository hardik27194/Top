//
//  PhotoStickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 27/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "PhotoStickerView.h"
#import "TopStyleDirector.h"

@interface PhotoStickerView ()
@property (nonatomic,weak) UILabel *numberLabel;
@end
@implementation PhotoStickerView

-(instancetype)initWithNumber:(NSNumber *)number{
    self = [super init];
    if (self) {
        _number = [number integerValue];
        self.layerRect = CGRectZero;
        
  
        UILabel *numberLabel = [[UILabel alloc]init];
        numberLabel.font = [UIFont systemFontOfSize:20];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.text = [NSString stringWithFormat:@"%li",(long)_number];
        [self addSubview:numberLabel];
        self.numberLabel = numberLabel;
       

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.numberLabel.frame = self.bounds;
    [self.delegate photoStickerView:self isFound:^(BOOL found) {
        self.found = found;
        if(found){
            [self showStickerPhoto];
            self.numberLabel.hidden = YES;
        }else{
            [self showPlaceholder];
            self.numberLabel.hidden = NO;
        }
    }];
   
}
-(void)showStickerPhoto{
    if (CGRectEqualToRect(self.layerRect, CGRectZero)) {
        return;
    }
    
    [self.delegate photoStickerView:self image:^(UIImage *image) {
        if (image == nil) {
            return;
        }
        self.layer.contents = (__bridge id)image.CGImage;
        self.layer.contentsGravity = kCAGravityResizeAspectFill;
        self.layer.contentsRect = _layerRect;
        self.styleState = TopViewStyleState_Selected;
    }];
}
-(void)showPlaceholder{
    self.layer.contents = nil;
    self.styleState = TopViewStyleState_Normal;
}

@end
