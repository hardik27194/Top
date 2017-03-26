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


static TopStickersDirector *sharedDirector = nil;

@interface TopStickersDirector ()
@property (nonatomic,assign) NSInteger totalStickers;
@property (nonatomic,strong) NSMutableDictionary *mainStructure;
@end

@implementation TopStickersDirector

+ (id)sharedDirector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDirector = [[self alloc] init];
    });
    return sharedDirector;
}
-(NSArray <TopPage *>*)askTopPages{
    NSArray <TopPage *> *pages = [self orderTopPages:[TopBackendLessData getAllTopPages]];
    
    self.totalStickers = 0;
    self.mainStructure = [[NSMutableDictionary alloc]init];
    NSMutableArray *pagesArray = [[NSMutableArray alloc]init];

    for (TopPage *page in pages) {
        NSMutableDictionary *pageDict = [[NSMutableDictionary alloc]init];
        NSMutableDictionary *stickers_in_page = [[NSMutableDictionary alloc]init];

        NSInteger stickers_count_in_page = 0;
        for (TopObject *object in page.topObjects) {
            NSInteger splitCount = object.split;
            stickers_count_in_page += splitCount;
            
            NSMutableArray *stickersNumberArray = [[NSMutableArray alloc]init];
            NSInteger tmpTotalSticker = self.totalStickers;
            for (int i = tmpTotalSticker; i < tmpTotalSticker+splitCount; i++){
                self.totalStickers += 1;
                [stickersNumberArray addObject:@(self.totalStickers)];

            }
            stickers_in_page[object.objectId] = stickersNumberArray;
            pageDict[@"stickers"] = stickers_in_page;
        }
        pageDict[@"count"] = @(stickers_count_in_page);
        [pagesArray addObject:pageDict];
    }
    
    self.mainStructure[@"pages"] = pagesArray;

    return pages;
}


- (NSArray<TopPage *> *)orderTopPages:(NSArray<TopPage *> * )pages{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [pages sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}

- (NSDictionary *)askStickersFromTopPage:(TopPage *)page{
    return self.mainStructure[@"pages"][page.number];
}
-(void)askFoundSticker:(NSNumber *)numberSticker inFoundedStickers:(NSArray *)foundedStickers completion:(void(^)(BOOL found))completionBlock{
    completionBlock([foundedStickers containsObject:numberSticker]);
}
@end
