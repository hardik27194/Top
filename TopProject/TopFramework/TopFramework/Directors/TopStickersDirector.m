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
@property (nonatomic,strong) NSMutableDictionary *stickers;

@end

@implementation TopStickersDirector

+ (id)sharedDirector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDirector = [[self alloc] init];
        sharedDirector.mainStructure = [[NSMutableDictionary alloc]init];
        sharedDirector.stickers = [[NSMutableDictionary alloc]init];
    });
    return sharedDirector;
}

#pragma mark -private -
- (void)layerRectForStickerWithRows:(NSInteger)rows
                   columns:(NSInteger)colums
            stickerNumbers:(NSArray *)stickerNumbers
                completion:(void(^)(CGRect layerRect,NSInteger number)) rectBlock {
    NSInteger index = 0;
    CGFloat portion_width = 1.0f / colums;
    CGFloat portion_height = 1.0f / rows;
    for (int row = 0; row < rows; row ++) {
        for (int column = 0; column < colums; column ++) {
            NSInteger number = [stickerNumbers[index] integerValue];
            CGFloat originX = column * portion_width;
            CGFloat originY = row * portion_height;
            CGRect layerRect = CGRectMake(originX, originY, portion_width, portion_height);
            rectBlock(layerRect,number);
            index++;
        }
    }
}
- (NSArray<TopCategory *> *)orderTopCategories:(NSArray<TopCategory *> * )categories{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [categories sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}
- (NSArray<TopPage *> *)orderTopPages:(NSArray<TopPage *> * )pages{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [pages sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}
-(void)cachePagesData:(NSArray <TopPage *>*)pages{
    if (self.mainStructure[@"pages"] != nil) {
        return;
    }
    self.totalStickers = 0;
    NSMutableArray *pagesArray = [[NSMutableArray alloc]init];
    
    for (TopPage *page in pages) {
        NSMutableDictionary *pageDict = [[NSMutableDictionary alloc]init];
        NSMutableDictionary *stickers_in_page = [[NSMutableDictionary alloc]init];
        NSInteger stickers_count_in_page = 0;
        
        for (TopObject *object in page.topObjects) {
            NSInteger splitCount = object.rows * object.columns;
            stickers_count_in_page += splitCount;
            NSMutableArray *stickersNumberArray = [[NSMutableArray alloc]init];
            NSInteger tmpTotalSticker = self.totalStickers;
            for (int i = (int)tmpTotalSticker; i < tmpTotalSticker+splitCount; i++){
                self.totalStickers += 1;
                
                [self saveStickerNumber:self.totalStickers
                                 object:object.image
                                withKey:@"image"];
                
                [self saveStickerNumber:self.totalStickers
                                 object:@(object.rarity)
                                withKey:@"rarity"];
                
                
                [stickersNumberArray addObject:@(self.totalStickers)];
            }
            
            
            [self layerRectForStickerWithRows:object.rows
                                      columns:object.columns
                               stickerNumbers:stickersNumberArray
                                   completion:^(CGRect layerRect, NSInteger number) {
                                       [self saveStickerNumber:number
                                                        object:NSStringFromCGRect(layerRect)
                                                       withKey:@"layer_rect"];
                                       
                                       
                                   }];
            
            stickers_in_page[object.objectId] = stickersNumberArray;
            pageDict[@"stickers"] = stickers_in_page;
        }
        pageDict[@"count"] = @(stickers_count_in_page);
        [pagesArray addObject:pageDict];
    }
    
    self.mainStructure[@"pages"] = pagesArray;
}

#pragma mark - ask -
-(NSArray <TopCategory *>*)askTopCategories{
    return  [self orderTopCategories:[TopBackendLessData getAllTopCategories]];
}
-(NSArray <TopPage *>*)askTopPagesForCategory:(TopCategory *)topCategory{
    
    NSArray <TopCategory *>*categories = [self askTopCategories];
    
        NSArray<TopPage *> *orderedPages = [self orderTopPages:[TopBackendLessData getAllTopPages]];
        NSMutableArray *tmpPages = [[NSMutableArray alloc]init];
        NSInteger idx = 0;
        for (TopCategory *category in categories) {
            for (TopPage *page in orderedPages) {
                if ([page.topCategory isEqual:category]) {
                    page.assignedIndex = idx;
                    [tmpPages addObject:page];
                    idx++;
                }
            }
        }
        [self cachePagesData:(NSArray *)tmpPages];
    
    NSMutableArray *pagesForCategory = [[NSMutableArray alloc]init];
    for (TopPage *page in tmpPages) {
        if ([page.topCategory isEqual:topCategory]) {
            [pagesForCategory addObject:page];
        }
    }
    
    return (NSArray <TopPage *> *)pagesForCategory;
}

- (NSDictionary *)askStickersFromTopPage:(TopPage *)page{
    return self.mainStructure[@"pages"][page.assignedIndex];
}
- (CGRect)askLayerRectFromStickerNumber:(NSInteger)number{
    NSString *stringRect = [self.stickers[@(number)] objectForKey:@"layer_rect"];
    return CGRectFromString(stringRect);
}
- (NSURL *)askUrlImageFromStickerNumber:(NSInteger)number{
    NSString *urlString = [self.stickers[@(number)] objectForKey:@"image"];
    return [NSURL URLWithString:urlString];
}
- (NSInteger)askTotalStickers{
    return self.stickers.count;
}
- (void)askStickerNumberFromRarity:(TopRarityLevel)topRarityLevel completion:(void(^)(NSInteger number,NSError *error))completion{
    
    NSMutableArray *mutStickers = [[NSMutableArray alloc]init];
    for (id key in self.stickers) {
        TopRarityLevel stickerRarityLevel = (TopRarityLevel)[[self.stickers[key] objectForKey:@"rarity"] integerValue];
        if (stickerRarityLevel == topRarityLevel) {
            [mutStickers addObject:key];
        }
    }
    if (mutStickers.count == 0) {
        completion(0,[NSError errorWithDomain:@"top error: no stickers with that rarity level" code:0 userInfo:nil]);
        return;
    }
    NSInteger randomNumber = arc4random() % mutStickers.count;
    completion([mutStickers[randomNumber] integerValue],nil);
}
#pragma mark - save -
-(void)saveStickerNumber:(NSInteger)number
                  object:(id)object
                 withKey:(NSString *)key{
    if (self.stickers[@(number)] == nil) {
        self.stickers[@(number)] = [[NSMutableDictionary alloc]init];
    }
    [self.stickers[@(number)] setObject:object forKey:key];
}
@end
