//
//  StickerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopObject.h"
#import "PhotoContainerStickersView.h"
#import "TopBaseStyledView.h"

@class StickerView;

@protocol StickerViewProtocol <NSObject>
-(void)stickerView:(StickerView *)stickerView askFoundStickers:(void(^)(NSArray *foundStickers))foundStickers;
-(void)tappedStickerView:(StickerView *)stickerView;
@end

@interface StickerView : TopBaseStyledView
@property (nonatomic,strong) UIImage *photo;
@property (nonatomic,weak) IBOutlet PhotoContainerStickersView *photoContainer;
@property (nonatomic,weak) IBOutlet UILabel *stickerTitleLabel;
@property (nonatomic,weak) IBOutlet UILabel *stickerDescriptionLabel;


@property (nonatomic,strong) NSArray *numberStickers;
@property (nonatomic,assign) id <StickerViewProtocol> delegate;

+ (id)stickerViewWithIdentifier:(NSString *)identifier;
- (void)updateFromTopObject:(TopObject *)topObject withNumbers:(NSArray *)numbers;
- (NSArray *)photoStickerViews;
- (TopObject *)topObject;
@end
