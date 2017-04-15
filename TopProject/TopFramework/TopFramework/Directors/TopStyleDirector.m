//
//  TopStyler.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 15/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopStyleDirector.h"
#import "TopAppDelegate.h"
#import "TopDefaultStyler.h"

static TopStyleDirector *sharedStyleDirector = nil;
static NSDictionary *selectors = nil;
@implementation TopStyleDirector

+ (TopStyleDirector *)sharedDirector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStyleDirector = [[self alloc] init];
        selectors = @{@"StickerView":[NSValue valueWithPointer:@selector(styleForStickerView:forState:)],
                      @"PhotoStickerView":[NSValue valueWithPointer:@selector(styleForPhotoStickerView:forState:)]};
    });
    return sharedStyleDirector;
}

- (TopStyle *)styleForView:(TopBaseStyledView *)styleView
                    forState:(TopViewStyleState)styleState{
    
    Class stylerClass = [TopAppDelegate topAppDelegate].stylerClass;
    if (stylerClass == nil) {
        stylerClass = [TopDefaultStyler class];
    }
    id <TopStylerProtocol> styler = [[stylerClass alloc]init];
    if (styler == nil) {
        return nil;
    }
    SEL delegateSelector = [selectors[NSStringFromClass([styleView class])] pointerValue];
    if (delegateSelector) {
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[(NSObject *)styler methodSignatureForSelector:delegateSelector]];
        [inv setSelector:delegateSelector];
        [inv setTarget:(NSObject *)styler ];
        [inv setArgument:&styleView atIndex:2];
        [inv setArgument:&styleState atIndex:3];
        [inv invoke];
        TopStyle * __unsafe_unretained tempResultSet;
        [inv getReturnValue:&tempResultSet];
        return (TopStyle *)tempResultSet;
    }

    return nil;
}

@end
