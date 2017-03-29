//
//  StickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "StickerView.h"
#import "PhotoContainerStickersView.h"

@interface StickerView()<PhotoStickerViewProtocol>{
    TopObject *_tObject;
}
@property (nonatomic,weak) PhotoContainerStickersView *photoContainer;
@property (nonatomic,weak) UILabel *stickerTitleLabel;
@property (nonatomic,weak) UILabel *stickerDescriptionLabel;
@property (nonatomic,strong) UIImage *photo;
@end
@implementation StickerView

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
                self.photo= [UIImage imageWithData:imageData];
                photoBlock(self.photo);
            });
        });
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self innerInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self innerInit];
    }
    return self;
}
-(void)build{
    NSInteger offsetY = 0;
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.stickerTitleLabel = titleLabel;
    
    offsetY += titleLabel.bounds.size.height;
    PhotoContainerStickersView *photoContainer = [[PhotoContainerStickersView alloc]init];
    
    [self addSubview:photoContainer];
    photoContainer.backgroundColor = [UIColor purpleColor];
    self.photoContainer = photoContainer;
    
    offsetY += photoContainer.bounds.size.height;
}
-(void)innerInit{
    [self build];
    
    self.backgroundColor = [UIColor colorWithRed:231/255.f green:231/255.f blue:231/255.f alpha:1];
}
-(void)updateFromTopObject:(TopObject *)topObject withNumbers:(NSArray *)numbers{
    _tObject = topObject;
    self.numberStickers = numbers;
    
    stickerContainerGrid grid;
    grid.columns = _tObject.columns;
    grid.rows = _tObject.rows;
    self.photoContainer.grid = grid;
    [self.photoContainer buildStickersFromNumbers:self.numberStickers
                                      andDelegate:self];

 
    self.stickerTitleLabel.text = topObject.title;
}


-(void)photoStickerView:(PhotoStickerView *)stickerNumberView image:(void (^)(UIImage *))imageBlock{
    [self photoWithUrl:[NSURL URLWithString:_tObject.image]
            completion:^(UIImage *image) {
        imageBlock(image);
    }];
}
-(void)photoStickerView:(PhotoStickerView *)stickerNumberView
              isFounded:(void (^)(BOOL))foundedBlock{
    [self.delegate stickerView:self askFoundedStickers:^(NSArray *foundedStickers) {
        foundedBlock([foundedStickers containsObject:@(stickerNumberView.number)]);
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger offsetY = 0;

    self.stickerTitleLabel.frame =  CGRectMake(0, offsetY, self.bounds.size.width, 30);
    offsetY += self.stickerTitleLabel.bounds.size.height;
    self.photoContainer.frame = CGRectMake(0, offsetY, self.bounds.size.width, self.bounds.size.height-30);
    [self.photoContainer layoutSubviews];
}
@end
