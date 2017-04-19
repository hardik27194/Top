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
@property (nonatomic,weak)  UIImageView *imageView;
@property (nonatomic,weak)  UILabel *titleLabel;
@property (nonatomic,weak)  UILabel *descriptionLabel;

@property (nonatomic,strong) UIView *shrinkedView;
@property (nonatomic,assign) CGPoint centerPoint;

@property (nonatomic,strong) UIImage *tmpImage;

@property (nonatomic,assign) id <TopDetailViewProtocol> detailProtocol;
- (void)updateWithTopObject:(TopObject *)topObject;


- (void)willShrink;
- (void)shrink;
- (void)didShrink;
- (void)expand;
- (void)updateStyle;

@end
