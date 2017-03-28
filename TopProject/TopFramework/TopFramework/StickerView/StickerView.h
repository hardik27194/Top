//
//  StickerView.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 22/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopObject.h"
@class StickerView;

@protocol StickerViewProtocol <NSObject>
-(void)stickerView:(StickerView *)stickerView askFoundedStickers:(void(^)(NSArray *foundedStickers))foundedStickers;
@end

@interface StickerView : UIView
@property (nonatomic,strong) NSArray *numberStickers;
@property (nonatomic,assign) id <StickerViewProtocol> delegate;
-(void)updateFromTopObject:(TopObject *)topObject withNumbers:(NSArray *)numbers;
@end
