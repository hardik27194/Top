//
//  TopDetailView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 12/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopDetailView;
@protocol TopDetailViewProtocol <NSObject>

-(void)topDetailView:(TopDetailView *)detailView askCloseWithData:(id)data;

@end
@interface TopDetailView : UIView
@property (nonatomic,assign) CGRect beginFrame;
@property (nonatomic,assign) id <TopDetailViewProtocol> detailProtocol;
+ (id)detailViewWithIdentifier:(NSString *)identifier;

@end
