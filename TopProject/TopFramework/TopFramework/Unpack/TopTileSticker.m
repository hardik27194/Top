//
//  TopTileSticker.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 07/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopTileSticker.h"
#import "TopStickersDirector.h"
@interface TopTileSticker()

@property (nonatomic,weak) UILabel *numberLabel;
@end

@implementation TopTileSticker
{
    int _xOffset, _yOffset;
    NSInteger _number;
}
#pragma mark - dragging the tile
-(void)photoWithUrl:(NSURL *)urlImage completion:(void(^)(UIImage *image))completionBlock{
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("top.process_images", NULL);
    
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:urlImage];
        dispatch_async(callerQueue, ^{
            completionBlock([UIImage imageWithData:imageData]);
        });
    });
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (instancetype)initWithFrame:(CGRect)frame
                    andNumber:(NSInteger)number
{
    self = [super initWithFrame:frame];
    if (self) {
        _number = number;
        NSURL *urlImage = [[TopStickersDirector sharedDirector] askUrlImageFromStickerNumber:_number];
        CGRect layerRect = [[TopStickersDirector sharedDirector] askLayerRectFromStickerNumber:_number];
        
        [self photoWithUrl:urlImage completion:^(UIImage *image) {
            UIImage *resizedImage = [self imageWithImage:image scaledToSize:self.bounds.size];
            self.layer.contents = (__bridge id)resizedImage.CGImage;
            self.layer.contentsGravity = kCAGravityResizeAspect;
            self.layer.contentsRect = layerRect;
            self.layer.masksToBounds = YES;
        }];
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 50)];
        numberLabel.font = [UIFont systemFontOfSize:30];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];

        numberLabel.text = [NSString stringWithFormat:@"%li",(long)_number];
        [self addSubview:numberLabel];
        self.numberLabel = numberLabel;
        self.numberLabel.alpha = 0;

        self.backgroundColor = [UIColor darkGrayColor];
        //self.layer.shadowColor = [[UIColor blackColor] CGColor];
       // self.layer.shadowOffset = CGSizeMake(0,5);
        //self.layer.shadowOpacity = 0.5;
    }
    return self;
}
-(NSInteger)number{
    return _number;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    _xOffset = pt.x - self.center.x;
    _yOffset = pt.y - self.center.y;
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformScale(self.transform, 1.30, 1.30);
    }];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 2;
   
    self.alpha = 0.5;
    self.numberLabel.alpha = 1;
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    self.center = CGPointMake(pt.x - _xOffset, pt.y - _yOffset);
    if (self.dragDelegate) {
        [self.dragDelegate tileView:self dragToPoint:self.center];
        self.alpha = 0.5;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIPageViewController *pointerPageViewController = (UIPageViewController *) self.superview;
    for (UIGestureRecognizer *recognizer in pointerPageViewController.gestureRecognizers) {
        recognizer.enabled = YES;
    }
    [self touchesMoved:touches withEvent:event];
    if (self.dragDelegate) {
        [self.dragDelegate tileView:self didDragToPoint:self.center];
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
    self.alpha = 1;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 0;
    self.numberLabel.alpha = 0;

}

@end
