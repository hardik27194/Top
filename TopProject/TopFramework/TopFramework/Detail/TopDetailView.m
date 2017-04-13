//
//  TopDetailView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 12/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopDetailView.h"
@interface TopDetailView (){
    TopObject *_tObject;
    UIImage *_photo;
}
@property (nonatomic,assign) CGRect initialFrame;

@end

@implementation TopDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _initialFrame = frame;
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        self.imageView = imageView;
        UILabel *titleLabel = [[UILabel alloc]init];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        UILabel *descriptionLabel = [[UILabel alloc] init];
        [self addSubview:descriptionLabel];
        self.descriptionLabel = descriptionLabel;
        [self expand];
        [self updateStyle];
    }
    return self;
}

-(void)photoWithUrl:(NSURL *)photoUrl completion:(void(^)(UIImage* image))photoBlock{
    if (_photo != nil) {
        photoBlock(_photo);
        return;
    }
    
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("top.process_images", NULL);
    
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:photoUrl];
        dispatch_async(callerQueue, ^{
            _photo = [UIImage imageWithData:imageData];
            photoBlock(_photo);
        });
    });
}

-(void)setTmpImage:(UIImage *)tmpImage{
    _tmpImage = tmpImage;
    self.imageView.image = tmpImage;
}
-(void)updateWithTopObject:(TopObject *)topObject{
    _tObject = topObject;
    /*
     [self photoWithUrl:[NSURL URLWithString:_tObject.image]
            completion:^(UIImage *image) {
//                self.imageView.image = image;
            }];
    */
    self.titleLabel.text = _tObject.title;
    self.descriptionLabel.text = _tObject.desc;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.detailProtocol topDetailView:self askCloseWithData:nil];
}

#pragma mark - style -
-(void)updateStyle{

}
-(void)setCenterPoint:(CGPoint)centerPoint{
    _centerPoint = centerPoint;
}
#pragma mark - shrink and expand -
-(void)willShrink{}
-(void)shrink{
    if (self.shrinkedView == nil) {
        return;
    }
    self.frame = self.shrinkedView.frame;
    
    UIView *photoContainerView = [self.shrinkedView valueForKeyPath:@"photoContainer"];
    if (photoContainerView != nil) {
        self.imageView.frame = photoContainerView.frame;
    }
    UIView *titleLabel = [self.shrinkedView valueForKeyPath:@"stickerTitleLabel"];
    if (titleLabel != nil) {
        self.titleLabel.frame = titleLabel.frame;
    }
    UIView *descriptionLabel = [self.shrinkedView valueForKeyPath:@"stickerDescriptionLabel"];
    if (descriptionLabel != nil) {
        self.descriptionLabel.frame = descriptionLabel.frame;
    }
    if (!CGPointEqualToPoint(CGPointZero, _centerPoint)) {
        self.center = _centerPoint;
    }
}
-(void)didShrink{}
-(void)expand{
    self.frame = _initialFrame;
}

@end
