//
//  StickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "StickerView.h"
#import "PhotoContainerStickersView.h"

@interface StickerView(){
    TopObject *_tObject;
}
@property (nonatomic,weak) PhotoContainerStickersView *photoContainer;
@property (nonatomic,weak) UILabel *stickerTitleLabel;
@property (nonatomic,weak) UILabel *stickerDescriptionLabel;
@end
@implementation StickerView

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
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, offsetY, self.bounds.size.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.stickerTitleLabel = titleLabel;
    
    offsetY += titleLabel.bounds.size.height;
    
    PhotoContainerStickersView *photoContainer = [[PhotoContainerStickersView alloc]initWithFrame:CGRectMake(0, offsetY, self.bounds.size.width, self.bounds.size.height/2)];
    photoContainer.backgroundColor = [UIColor grayColor];
    photoContainer.layer.masksToBounds = YES;
    photoContainer.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:photoContainer];
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
    [self.photoContainer buildPhotoWithUrl:[NSURL URLWithString:_tObject.image] stickerViewFromNumbers:self.numberStickers];
    self.stickerTitleLabel.text = topObject.title;
}
-(void)updateNumber:(NSNumber *)number ifFounded:(BOOL)found{
    
    [self.photoContainer number:number found:found];

    if (found == NO) {
//        self.stickerImageView.image = nil;
        return;
    }

//    [self.stickerImageView setImageWithURL:[NSURL URLWithString:_tObject.image] placeholderImage:nil];
}
@end
