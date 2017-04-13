//
//  TopDetailView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 12/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopObject.h"

@class TopDetailView;
@protocol TopDetailViewProtocol <NSObject>

-(void)topDetailView:(TopDetailView *)detailView askCloseWithData:(id)data;

@end
@interface TopDetailView : UIView
@property (nonatomic,weak) IBOutlet UIImageView *imageView;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *descriptionLabel;

@property (nonatomic,strong) UIImage *tmpImage;

@property (nonatomic,assign) CGRect beginFrame;
@property (nonatomic,assign) CGRect beginStickerPhotoFrame;

@property (nonatomic,assign) id <TopDetailViewProtocol> detailProtocol;
+ (id)detailViewWithIdentifier:(NSString *)identifier;
- (void)updateWithTopObject:(TopObject *)topObject;
@end
