//
//  StickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "StickerView.h"

@interface StickerView()<PhotoStickerViewProtocol>{
    TopObject *_tObject;
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
    self.stickerDescriptionLabel.text = topObject.desc;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.photoContainer layoutSubviews];
}

#pragma mark - delegates -

-(void)photoStickerView:(PhotoStickerView *)stickerNumberView image:(void (^)(UIImage *))imageBlock{
    [self photoWithUrl:[NSURL URLWithString:_tObject.image]
            completion:^(UIImage *image) {
        imageBlock(image);
    }];
}
-(void)photoStickerView:(PhotoStickerView *)stickerNumberView
              isFound:(void (^)(BOOL))foundBlock{
    [self.delegate stickerView:self askFoundStickers:^(NSArray *foundStickers) {
        foundBlock([foundStickers containsObject:@(stickerNumberView.number)]);
    }];
}

@end
