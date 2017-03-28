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
@property (nonatomic,weak) UILabel *numberLabel;
@end
@implementation PhotoStickerView
- (instancetype)initWithNumber:(NSNumber *)number
                         frame:(CGRect)frameRect
                  andLayerRect:(CGRect)layerRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        _number = [number integerValue];
        _layerRect = layerRect;
        self.backgroundColor = [UIColor redColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:self.bounds];
        numberLabel.font = [UIFont systemFontOfSize:20];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.text = [NSString stringWithFormat:@"%i",_number];
        [self addSubview:numberLabel];
        self.numberLabel = numberLabel;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.delegate photoStickerView:self isFounded:^(BOOL founded) {
        if(founded){
            [self showStickerPhoto];
            self.numberLabel.hidden = YES;
        }else{
            [self showPlaceholder];
            self.numberLabel.hidden = NO;
        }
    }];
   
}
-(void)showStickerPhoto{
    [self.delegate photoStickerView:self image:^(UIImage *image) {
        if (image == nil) {
            return;
        }
        self.layer.contents = (__bridge id)image.CGImage;
        self.layer.contentsRect = _layerRect;
        self.layer.contentsGravity = kCAGravityResizeAspectFill;
        NSLog(@"show image in %i",self.number);
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor greenColor];
    }];
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
