//
//  StickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "StickerView.h"
#import "TopAppDelegate.h"
#import "TopStyleDirector.h"
@import AVFoundation;

@interface StickerView()<PhotoStickerViewProtocol,PhotoContainerStickerViewProtocol>{
    TopObject *_tObject;
    NSMutableArray *_requests;
    BOOL found;
    
}
@end
@implementation StickerView
+ (id)stickerViewWithIdentifier:(NSString *)identifier {
    UINib *nib = [UINib nibWithNibName:identifier
                                bundle:[NSBundle bundleForClass:[self class]]];
    StickerView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:view action:@selector(pressSticker)];
    [view addGestureRecognizer:tapGesture];
    
   
    return view;
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
//    CGRect rect  = AVMakeRectWithAspectRatioInsideRect(image.size,self.frame);
//    UIGraphicsBeginImageContext(newSize);
//    [image drawInRect:rect blendMode:kCGBlendModePlusDarker alpha:1];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}

-(void)photoWithUrl:(NSURL *)photoUrl completion:(void(^)(UIImage* image))photoBlock{
    if (self.photo != nil) {
        photoBlock(self.photo);
        return;
    }
        dispatch_queue_t downloadQueue = dispatch_queue_create("top.process_images", NULL);
        dispatch_async(downloadQueue, ^{
            NSData * imageData = [NSData dataWithContentsOfURL:photoUrl];
            self.photo = [self imageWithImage:[UIImage imageWithData:imageData] scaledToSize:self.bounds.size];
            photoBlock(self.photo);
        });
}


-(void)updateFromTopObject:(TopObject *)topObject withNumbers:(NSArray *)numbers{
    found = NO;
    _tObject = topObject;
    self.numberStickers = numbers;
    _requests = [[NSMutableArray alloc]init];
    stickerContainerGrid grid;
    grid.columns = _tObject.columns;
    grid.rows = _tObject.rows;
    self.photoContainer.grid = grid;
    self.photoContainer.containerDelegate = self;
    [self.photoContainer buildStickersFromNumbers:self.numberStickers
                                      andDelegate:self];

 
    self.stickerTitleLabel.text = topObject.title;
    self.stickerDescriptionLabel.text = topObject.desc;
    [self photoWithUrl:[NSURL URLWithString:_tObject.image]
            completion:^(UIImage *image) {
                for (void(^block)(UIImage *photo) in _requests) {
                    block(image);
                }
        _requests = nil;
    }];
    
}
-(void)setPhoto:(UIImage *)photo{
    _photo = photo;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.photoContainer layoutSubviews];
}
-(NSArray *)photoStickerViews{
    return [self.photoContainer photoStickerViews];
}
#pragma mark - retrieve -
-(TopObject *)topObject{
    return _tObject;
}
#pragma mark - delegates -
-(void)photoStickerView:(PhotoStickerView *)stickerNumberView image:(void (^)(UIImage *))imageBlock{
    if (self.photo) {
        imageBlock(self.photo);
        return;
    }
    [_requests addObject:[imageBlock copy]];
}
-(void)photoStickerView:(PhotoStickerView *)stickerNumberView
              isFound:(void (^)(BOOL))foundBlock{
    [self.delegate stickerView:self askFoundStickers:^(NSArray *foundStickers) {
        foundBlock([foundStickers containsObject:@(stickerNumberView.number)]);
    }];
}
-(void)photoContainer:(PhotoContainerStickersView *)photoContainer cointainerIsCompleted:(BOOL)completed{
    found = completed;
    if (found) {
        self.styleState = TopViewStyleState_Selected;
    }else{
        self.styleState = TopViewStyleState_Normal;
    }
}
#pragma mark - handle tap -
-(void)pressSticker{
    if (found){
        [self.delegate tappedStickerView:self];
    }
}
#pragma mark - custom styles -
-(void)applyStyle:(TopStyle *)style{
    [super applyStyle:style];
    self.stickerTitleLabel.font = style.textFont;
    self.stickerTitleLabel.textColor = style.textColor;
    self.stickerTitleLabel.textAlignment = style.textAlign;
}
@end
