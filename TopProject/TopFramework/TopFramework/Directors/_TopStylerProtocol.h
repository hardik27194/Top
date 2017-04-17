//
//  _TopStylerProtocol.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 15/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopStyle.h"
#import "TopBaseStyledView.h"
#import "TopBaseStyledButton.h"

#ifndef _TopStylerProtocol_h
#define _TopStylerProtocol_h

@protocol TopStylerProtocol <NSObject>
- (TopStyle *)styleForStickerView:(TopBaseStyledView*)view
                        forState:(TopViewStyleState)state;
- (TopStyle *)styleForPhotoStickerView:(TopBaseStyledView*)view
                        forState:(TopViewStyleState)state;


- (TopStyle *)styleForTopPacketsButton:(TopBaseStyledButton *)button
                              forState:(TopViewStyleState)state;
- (TopStyle *)styleForTopDoubleButton:(TopBaseStyledButton *)button
                              forState:(TopViewStyleState)state;
- (TopStyle *)styleForTopTempButton:(TopBaseStyledButton *)button
                             forState:(TopViewStyleState)state;
@end


#endif /* _TopStylerProtocol_h */
