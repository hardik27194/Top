//
//  StickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "StickerView.h"

@interface StickerView()<PhotoStickerViewProtocol,PhotoContainerStickerViewProtocol>{
    TopObject *_tObject;
    NSMutableArray *_requests;
    BOOL found;
    
}
@property (nonatomic,strong) UIImage *photo;
@end
@implementation StickerView
+ (id)stickerViewWithIdentifier:(NSString *)identifier {
    UINib *nib = [UINib nibWithNibName:identifier
                                bundle:[NSBundle bundleForClass:[self class]]];
    StickerView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    return view;
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)photoWithUrl:(NSURL *)photoUrl completion:(void(^)(UIImage* image))photoBlock{
    if (self.photo != nil) {
        photoBlock(self.photo);
        return;
    }
    
        dispatch_queue_t callerQueue = dispatch_get_current_queue();
        dispatch_queue_t downloadQueue = dispatch_queue_create("top.process_images", NULL);
        
        dispatch_async(downloadQueue, ^{
            NSData * imageData = [NSData dataWithContentsOfURL:photoUrl];
            dispatch_async(callerQueue, ^{
                self.photo = [self imageWithImage:[UIImage imageWithData:imageData] scaledToSize:self.bounds.size];
                photoBlock(self.photo);
            });
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
    self.backgroundColor = [UIColor redColor];
}
#pragma mark - handle tap -
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (found){
        [self.delegate tappedStickerView:self];
    }
}
@end
