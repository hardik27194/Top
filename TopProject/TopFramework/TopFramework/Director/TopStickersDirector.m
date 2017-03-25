//
//  TopStickersDirector.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 25/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopStickersDirector.h"
#import "TopBackendLessData.h"
#import "TopBackendLessUserData.h"
@interface TopStickersDirector ()
@property (nonatomic,assign) NSInteger totalStickers;

@end

@implementation TopStickersDirector
-(NSArray <TopPage *>*)askTopPages{
    NSArray <TopPage *> *pages = [TopBackendLessData getAllTopPages];
    
    self.totalStickers = 0;
    for (TopPage *page in pages) {
        NSUInteger count = page.topObjects.count;
        self.totalStickers += count;
    }
    
    return pages;
}


- (NSArray *)orderTopPages:(NSArray<TopPage *> * )pages{
    
    
    return nil;
}

- (void)stickersFromPage:(BasePageViewController *)page{
    

}

@end
