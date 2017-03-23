//
//  StickerView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "StickerView.h"
@interface StickerView()
@property (nonatomic,weak) UIImageView *stickerImageView;
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
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, offsetY, self.bounds.size.width, self.bounds.size.height/2)];
    imageView.backgroundColor = [UIColor grayColor];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    self.stickerImageView = imageView;
    
    offsetY += imageView.bounds.size.height;
}
-(void)innerInit{
    [self build];
    
    self.backgroundColor = [UIColor colorWithRed:231/255.f green:231/255.f blue:231/255.f alpha:1];
}
-(void)updateFromTopObject:(TopObject *)topObject{
    
    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:topObject.image]];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.stickerImageView.image = [UIImage imageWithData:imageData];
    });
    self.stickerTitleLabel.text = topObject.title;
}
@end
