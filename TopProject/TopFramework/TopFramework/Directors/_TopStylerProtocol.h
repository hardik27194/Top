//
//  _TopStylerProtocol.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 15/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopStyle.h"
#import "TopBaseStyledView.h"


#ifndef _TopStylerProtocol_h
#define _TopStylerProtocol_h

@protocol TopStylerProtocol <NSObject>
-(TopStyle *)styleForStickerView:(TopBaseStyledView*)view
                        forState:(TopViewStyleState)state;
-(TopStyle *)styleForPhotoStickerView:(TopBaseStyledView*)view
                        forState:(TopViewStyleState)state;
@end


#endif /* _TopStylerProtocol_h */
