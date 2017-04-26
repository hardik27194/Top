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
@property (nonatomic,weak) UIImageView *photoView;

@end

@implementation TopTileSticker
{
    int _xOffset, _yOffset;
    NSInteger _number;
}
#pragma mark - dragging the tile
-(void)photoWithUrl:(NSURL *)urlImage completion:(void(^)(UIImage *image))completionBlock{
    dispatch_queue_t downloadQueue = dispatch_queue_create("top.process_images", NULL);
    
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:urlImage];
        dispatch_async(callerQueue, ^{
            completionBlock([UIImage imageWithData:imageData]);
        });    });
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (instancetype)initWithNumber:(NSInteger)number type:(TopTileStickerType)type{
    
    NSDictionary *types = @{@(TopTileStickerType_small_horizontal):NSStringFromCGRect(CGRectZero),
                            @(TopTileStickerType_big_horizontal):NSStringFromCGRect(CGRectZero),
                            @(TopTileStickerType_small_vertical):NSStringFromCGRect(CGRectMake(0, 0, 80, 100)),
                            @(TopTileStickerType_big_vertical):NSStringFromCGRect(CGRectZero)};
    
    self = [super initWithFrame:CGRectFromString(types[@(type)])];
    if (self) {
        _number = number;
        NSURL *urlImage = [[TopStickersDirector sharedDirector] askUrlImageFromStickerNumber:_number];
        CGRect layerRect = [[TopStickersDirector sharedDirector] askLayerRectFromStickerNumber:_number];
        
        
        
        
        CGSize photoSize = CGSizeMake(50, 50);
        UIImageView *photoView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-photoSize.width)/2, 10, photoSize.width, photoSize.height)
                                  ];
        photoView.backgroundColor = [UIColor redColor];
        [photoView.layer addSublayer:[self addDashedBorderWithColor:[[UIColor blackColor] CGColor] toView:photoView]];
        photoView.layer.masksToBounds = YES;
        [self addSubview:photoView];
        
        
        
        self.photoView = photoView;
        
        [self photoWithUrl:urlImage completion:^(UIImage *image) {
            UIImage *resizedImage = [self imageWithImage:image scaledToSize:self.bounds.size];
            self.photoView.layer.contents = (__bridge id)resizedImage.CGImage;
//            self.photoView.layer.contentsGravity = kCAGravityResizeAspect;
            self.photoView.layer.contentsRect = layerRect;
            self.photoView.layer.masksToBounds = YES;
            self.layer.contents = (__bridge id)resizedImage.CGImage;
            self.layer.contentsGravity = kCAGravityResizeAspectFill;
        }];
        
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-30, self.bounds.size.width, 30)];
        numberLabel.font = [UIFont systemFontOfSize:15];
        numberLabel.textAlignment = NSTextAlignmentCenter;        
        numberLabel.text = [NSString stringWithFormat:@"%li",(long)_number];
        
        [self addSubview:numberLabel];
        
        self.numberLabel = numberLabel;
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
        [self setStyleState:TopViewStyleState_Highlighted];
    }];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    self.center = CGPointMake(pt.x - _xOffset, pt.y - _yOffset);
    if (self.dragDelegate) {
        [self.dragDelegate tileView:self dragToPoint:self.center];
        [self setStyleState:TopViewStyleState_Highlighted];
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
        [self setStyleState:TopViewStyleState_Normal];
    }];
}
- (CAShapeLayer *) addDashedBorderWithColor: (CGColorRef) color toView:(UIView *)view {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    CGSize frameSize = view.bounds.size;
    
    CGRect shapeRect = CGRectMake(0.0f, 0.0f, frameSize.width, frameSize.height);
    [shapeLayer setBounds:shapeRect];
    [shapeLayer setPosition:CGPointMake( frameSize.width/2,frameSize.height/2)];
    
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:color];
    [shapeLayer setLineWidth:3.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
      [NSNumber numberWithInt:5],
      nil]];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:shapeRect cornerRadius:0];
    [shapeLayer setPath:path.CGPath];
    
    return shapeLayer;
}
#pragma mark - custom styles -
-(void)applyStyle:(TopStyle *)style{
    [super applyStyle:style];
    self.numberLabel.textColor = style.supporTextColor;
    
}
@end
